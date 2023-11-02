Darktable의 filmic rgb의 auto tune levels를 자동으로 적용하기 위해 만들었습니다.

화면의 변화가 없으면 자동 클릭을 멈춥니다.

의존성은 아래 명령어로 해결가능합니다.

sudo pacman -S imagemagick
gem install mini_magick


실행 명령과 옵션은 아래와 같습니다.
ruby run.rb -a [전체 사진 개수] -t [반복 횟수]


화면 비교를 위해 스크린샷을 남기는데 이 좌표는 코드에서 수정해야 합니다.

def capture_screen(filename)
  `import -window root -crop 706x875+1623+2334 #{filename}`
end

부분에서'706x875+1623+2334'를 상황에 맞게 수정하세요.
