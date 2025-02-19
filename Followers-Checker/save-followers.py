import requests
import tkinter as tk
from tkinter import ttk, messagebox, filedialog

def get_roblox_followers(user_id):
    url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100"
    all_followers = []

    try:
        while url:
            response = requests.get(url)
            response.raise_for_status()

            data = response.json()
            followers = data.get("data", [])
            all_followers.extend(followers)

            url = data.get("nextPageCursor")
            if url:
                url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100&cursor={url}"

        if not all_followers:
            messagebox.showinfo("Aviso", "Nenhum seguidor encontrado.")
            return

        follower_ids = [str(follower["id"]) for follower in all_followers]
        names = get_usernames(follower_ids)

        filename = filedialog.asksaveasfilename(
            defaultextension=".txt",
            filetypes=[("Arquivo de Texto", "*.txt")],
            title="Salvar lista de seguidores",
            initialfile=f"seguidores_{user_id}.txt"
        )

        if not filename:
            return

        with open(filename, "w", encoding="utf-8") as file:
            file.write(f"Lista de seguidores do usuário {user_id}:\n")
            for index, follower in enumerate(all_followers, start=1):
                follower_id = follower["id"]
                follower_name = names.get(follower_id, "Sem nome")
                line = f"{index}. ID: {follower_id} - Nome: {follower_name}\n"
                file.write(line)

        messagebox.showinfo("Sucesso", f"Lista salva em '{filename}' com sucesso!")

    except requests.exceptions.RequestException as e:
        messagebox.showerror("Erro", f"Erro ao acessar a API: {e}")

def get_usernames(user_ids):
    url = "https://users.roblox.com/v1/users"
    payload = {"userIds": user_ids}
    headers = {"Content-Type": "application/json"}

    try:
        response = requests.post(url, json=payload, headers=headers)
        response.raise_for_status()
        data = response.json()
        return {user["id"]: user["name"] for user in data["data"]}
    except requests.exceptions.RequestException as e:
        messagebox.showerror("Erro", f"Erro ao buscar nomes: {e}")
        return {}


def on_search():
    user_id = entry_id.get().strip()
    if not user_id.isdigit():
        messagebox.showerror("Erro", "Por favor, insira um ID válido (somente números).")
        return
    get_roblox_followers(user_id)

# Criando a interface gráfica melhorada
root = tk.Tk()
root.title("Buscar Seguidores")
root.geometry("300x150")
root.resizable(False, False)

# Centralizar a tela
root.eval('tk::PlaceWindow . center')

frame = ttk.Frame(root, padding=15)
frame.pack(expand=True)

ttk.Label(frame, text="Digite o ID do usuário:", font=("Arial", 10)).pack(pady=5)
entry_id = ttk.Entry(frame, width=25, font=("Arial", 10))
entry_id.pack(pady=5)

btn_search = ttk.Button(frame, text="Salvar Seguidores", command=on_search)
btn_search.pack(pady=10)

root.mainloop()