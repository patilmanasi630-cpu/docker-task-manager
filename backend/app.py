from flask import Flask, request, jsonify, render_template
import os
import psycopg2
import time

app = Flask(__name__)


def get_db_connection():
    database_url = os.getenv("DATABASE_URL")

    if not database_url:
        raise Exception("DATABASE_URL is not set")

    return psycopg2.connect(database_url)


def init_db():
    for attempt in range(15):
        try:
            conn = get_db_connection()
            cur = conn.cursor()

            cur.execute("""
                CREATE TABLE IF NOT EXISTS tasks (
                    id SERIAL PRIMARY KEY,
                    title TEXT NOT NULL
                )
            """)

            conn.commit()
            cur.close()
            conn.close()

            print("Database initialized successfully")
            return

        except psycopg2.OperationalError as error:
            print(f"Waiting for database... Attempt {attempt + 1}/15")
            print(f"Database connection error: {error}")
            time.sleep(3)

    raise Exception("Could not connect to database")


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT 1")

        cur.close()
        conn.close()

        return jsonify({
            "status": "healthy",
            "database": "connected"
        })

    except Exception as error:
        print(f"Health check error: {error}")

        return jsonify({
            "status": "unhealthy",
            "database": "disconnected"
        }), 503


@app.route("/tasks", methods=["GET"])
def get_tasks():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("SELECT id, title FROM tasks ORDER BY id")
    tasks = cur.fetchall()

    cur.close()
    conn.close()

    return jsonify([
        {
            "id": task[0],
            "title": task[1]
        }
        for task in tasks
    ])


@app.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json()

    if not data or not data.get("title"):
        return jsonify({
            "error": "Task title is required"
        }), 400

    title = data["title"]

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO tasks (title) VALUES (%s) RETURNING id",
        (title,)
    )

    task_id = cur.fetchone()[0]

    conn.commit()

    cur.close()
    conn.close()

    return jsonify({
        "id": task_id,
        "title": title
    }), 201


@app.route("/tasks/<int:task_id>", methods=["DELETE"])
def delete_task(task_id):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        "DELETE FROM tasks WHERE id = %s",
        (task_id,)
    )

    conn.commit()

    cur.close()
    conn.close()

    return jsonify({
        "message": "Task deleted"
    })


if __name__ == "__main__":
    init_db()

    port = int(os.getenv("PORT", 5000))

    app.run(
        host="0.0.0.0",
        port=port
    )
