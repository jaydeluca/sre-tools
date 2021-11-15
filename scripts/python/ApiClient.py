import requests


class ApiClient(object):

    def __init__(self, api_key):
        self.session = requests.Session()
        self.session.headers.update({'api-key': api_key})
        self.base_url = 'https://api.ipify.org'

    def _get(self, url):
        try:
            return self.session.get(url)
        except Exception as e:
            print(e)

    def get_google(self) -> requests.models.Response:
        return self._get(self.base_url+'?format=json')