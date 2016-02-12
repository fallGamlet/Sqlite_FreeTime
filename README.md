# Sqlite_FreeTime
SQLite script to get cut from the original interval many small intervals

Source data: tables worktime and records

CREATE TABLE "worktime" (
    "_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "start" INTEGER NOT NULL,
    "end" INTEGER NOT NULL,
    ****** other columns ***
)

CREATE TABLE "records" (
    "_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "start" INTEGER,
    "end" INTEGER,
    ****** other columns ***
)


