import sys
import subprocess

# Python 설치 경로 출력
python_path = sys.executable
print(f"Python 설치 경로: {python_path}")

# Python 버전 출력
python_version = sys.version
print(f"Python 버전: {python_version}")

# pip 버전 출력
try:
    pip_version = subprocess.check_output([sys.executable, '-m', 'pip', '--version'])
    pip_list = subprocess.check_output([sys.executable, '-m', 'pip', 'list'])
    pip_version = pip_version.decode('utf-8').strip()
    print(f"pip 버전: {pip_version}")
    print(pip_list.decode('utf-8'))
except subprocess.CalledProcessError as e:
    print("pip를 확인할 수 없습니다.", e)

