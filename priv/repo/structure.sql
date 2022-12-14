CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" INTEGER PRIMARY KEY, "inserted_at" TEXT_DATETIME);
CREATE TABLE IF NOT EXISTS "users" ("id" INTEGER PRIMARY KEY, "email" TEXT NOT NULL COLLATE NOCASE, "hashed_password" TEXT NOT NULL, "confirmed_at" TEXT, "inserted_at" TEXT NOT NULL, "updated_at" TEXT NOT NULL) STRICT;
CREATE UNIQUE INDEX "users_email_index" ON "users" ("email");
CREATE TABLE IF NOT EXISTS "users_tokens" ("id" INTEGER PRIMARY KEY, "user_id" INTEGER NOT NULL CONSTRAINT "users_tokens_user_id_fkey" REFERENCES "users"("id") ON DELETE CASCADE, "token" BLOB NOT NULL, "context" TEXT NOT NULL, "sent_to" TEXT, "inserted_at" TEXT NOT NULL) STRICT;
CREATE INDEX "users_tokens_user_id_index" ON "users_tokens" ("user_id");
CREATE UNIQUE INDEX "users_tokens_context_token_index" ON "users_tokens" ("context", "token");
INSERT INTO schema_migrations VALUES(20221208135151,'2022-12-08T14:07:36');
