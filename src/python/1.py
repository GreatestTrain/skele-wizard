#!/bin/python

import os
import subprocess
import logging

FORMAT = ''
logger = logging.getLogger()

kernels = {
        'mainline': 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git',
        'lts': 'https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git',
        'zen': 'https://github.com/zen-kernel/zen-kernel'
}

def get_kernel(kernel: str = 'mainline', mode: str = 'git') -> None:
    if kernel not in kernels.keys():
        raise Exception(f'Avaible kernels. {list(kernels.keys())}')
    if mode not in (_ := ['git', 'wget']):
        raise Exception(f'Select a valid mode. {_}')
    linux_url = kernels[kernel]
    # Fetch kernel
    try:
        fetch_results = subprocess.run([
            'git', 'clone', linux_url, f'./{kernel}'
        ])
    except KeyboardInterrupt as ke:
        logger.warning('Interruption. Keyboard Interrupt.')
    except Exception as e:
        logger.error(e)

def compile_kernel(kernel: str = 'mainline', n_threads: str = 0):
    if kernel not in kernels.keys():
        raise Exception(f'Avaible kernels {list(kernels.keys())}')
    linux_url = kernels[kernel]
