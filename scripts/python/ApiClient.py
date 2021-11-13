import requests


class ApiClient(object):

    def __init__(self, api_key):
        self.session = requests.Session()
        self.session.headers.update({'api-key': api_key})

    def _get(self, url):
        try:
            return self.session.get(url)
        except Exception as e:
            print(e)

    def get_google(self):
        return self._get('https://google.com')