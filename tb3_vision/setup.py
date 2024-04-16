from setuptools import find_packages, setup

package_name = 'tb3_vision'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='asakayusuke',
    maintainer_email='asakayusuke@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
        "smile_cascade_node = tb3_vision.smile_cascade2:main", #pythonファイルごとに書く！
        "mayu_new_node = tb3_vision.vision:main",
        ],
    },
)
