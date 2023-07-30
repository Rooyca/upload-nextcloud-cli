import requests, sys, colorama

colorama.init()

headers = {
    'X-Requested-With': 'XMLHttpRequest'
}

def upload_file_to_url(url, file_path, username):
	with open(file_path, 'rb') as file:
		try:
			response = requests.put(url, data=file, auth=(username, ''), headers=headers)
		except Exception as e:
			print("-"*30)
			print(colorama.Fore.RED +"[ x ] Failed to upload the file. "+colorama.Style.RESET_ALL)
			print("-"*30)
			print(e)
			sys.exit(1)

	if response.status_code == 201:
		print("-"*30)
		print(colorama.Fore.GREEN +"File uploaded successfully.")
		print("-"*30)
	else:
		print("-"*30)
		print(colorama.Fore.RED +"[ x ]"+colorama.Style.RESET_ALL +f"Failed to upload the file. Status code: {response.status_code}")
		print("-"*30)
		print(colorama.Fore.RED + response.text)

if __name__ == "__main__":
	if not len(sys.argv) <= 3:
		print("-"*30)
		print("Usage: python script_name.py <url> <file_path>")
		print("-"*30)
		sys.exit(1)

	for arg in sys.argv:
		if arg.startswith('http'):
			url_org = arg
		else:
			file_path = arg

	url = url_org.split('/index.php')[0] + '/public.php/webdav/' + file_path.split('/')[-1]
	username = url_org.split('/')[-1]

	upload_file_to_url(url, file_path, username)