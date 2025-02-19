import requests

def get_roblox_followers(user_id):
    url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100"
    all_followers = []

    try:
        while url:
            response = requests.get(url)
            response.raise_for_status()

            data = response.json()
            followers = data.get("data", [])
            all_followers.extend(followers)  # Adiciona à lista total

            # Verifica se há mais páginas de seguidores
            url = data.get("nextPageCursor")
            if url:
                url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100&cursor={url}"

        # Se não houver seguidores
        if not all_followers:
            print("Nenhum seguidor encontrado.")
            return

        # Obter os nomes corretos usando uma API separada
        follower_ids = [str(follower["id"]) for follower in all_followers]
        names = get_usernames(follower_ids)

        # Criar e salvar a lista no arquivo
        filename = f"seguidores_{user_id}.txt"
        with open(filename, "w", encoding="utf-8") as file:
            file.write(f"Lista de seguidores do usuário {user_id}:\n")
            for index, follower in enumerate(all_followers, start=1):
                follower_id = follower["id"]
                follower_name = names.get(follower_id, "Sem nome")  # Busca o nome real
                line = f"{index}. ID: {follower_id} - Nome: {follower_name}\n"
                print(line, end="")  # Também exibe no console
                file.write(line)

        print(f"\nLista salva em '{filename}' com sucesso!")

    except requests.exceptions.RequestException as e:
        print(f"Erro ao acessar a API: {e}")

def get_usernames(user_ids):
    """ Faz uma requisição para obter os nomes corretos dos usuários """
    url = "https://users.roblox.com/v1/users"
    payload = {"userIds": user_ids}
    headers = {"Content-Type": "application/json"}

    try:
        response = requests.post(url, json=payload, headers=headers)
        response.raise_for_status()
        data = response.json()

        return {user["id"]: user["name"] for user in data["data"]}

    except requests.exceptions.RequestException as e:
        print(f"Erro ao buscar nomes: {e}")
        return {}

# Executar a função com seu ID
user_id = 584209058
get_roblox_followers(user_id)
