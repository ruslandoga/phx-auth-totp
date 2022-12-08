defmodule App.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Accounts` context.
  """
  alias App.{Repo, Accounts}

  @totp_secret Base.decode32!("PTEPUGZ7DUWTBGMW4WLKB6U63MGKKMCA")

  def unique_user_email, do: "user#{System.unique_integer([:positive])}@example.com"
  def valid_user_password, do: "hello world!"
  def valid_totp_secret, do: @totp_secret

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Accounts.register_user()

    user
  end

  def user_totp_fixture(user) do
    %Accounts.UserTOTP{}
    |> Ecto.Changeset.change(user_id: user.id, secret: valid_totp_secret())
    |> Accounts.UserTOTP.ensure_backup_codes()
    |> Repo.insert!()
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
