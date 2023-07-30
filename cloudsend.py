import requests, sys

headers = {
    'X-Requested-With': 'XMLHttpRequest'
}

def upload_file_to_url(url, file_path, username):
	with open(file_path, 'rb') as file:
		response = requests.put(url, data=file, auth=(username, ''), headers=headers)

	if response.status_code == 201:
		print("File uploaded successfully.")
	else:
		print(f"Failed to upload the file. Status code: {response.status_code}")
		print(response.text)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script_name.py <url> <file_path>")
        sys.exit(1)

    url_org = sys.argv[1]
    file_path = sys.argv[2]

    url = url_org.split('/index.php')[0] + '/public.php/webdav/' + file_path.split('/')[-1]
    username = url_org.split('/')[-1]

    upload_file_to_url(url, file_path, username)