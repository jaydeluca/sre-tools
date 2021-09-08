import logging
from multiprocessing.pool import Pool
from time import time


logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logging.getLogger('requests').setLevel(logging.CRITICAL)
logger = logging.getLogger(__name__)

test_list = [
    1,
    2,
    3,
    4,
    5
]

def test_function(item):
    print(item)

def main():
    ts = time()
    with Pool(4) as p:
        p.map(test_function, test_list)
    logging.info('Took %s seconds', time() - ts)


if __name__ == '__main__':
    main()