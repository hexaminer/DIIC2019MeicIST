function getRequest(url) {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', url);
  
  xhr.onreadystatechange = () => {
    console.log(xhr.responseText);
  }

  xhr.send();
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function update() {
  console.log("[+] Updated");
  const xhr = new XMLHttpRequest();

  xhr.onreadystatechange = () => {
    if (xhr.readyState == 4) {
      let data = JSON.parse(xhr.responseText);
      console.log(data);
      let last_baths = document.getElementsByClassName('bath');
      let info = document.getElementsByClassName('info');

      console.log(data.baths);
      console.log(last_baths);
      for (let i = 0; i < data.baths.length && i < last_baths.length; ++i) {
        console.log(i);

        let names = data.baths[i].name.split(' ');
        last_baths[i].childNodes[3].innerHTML = '<p>' + names[0] + '</p><p>' + names[1] + '</p>';
        last_baths[i].style.visibility = 'visible';
      }

      let percentage = data.total_water / 5;
      document.getElementById('water').style.height = (percentage > 5 ? 5 : percentage) * 100 + "%";
    }

  }
  xhr.open('GET', 'http://127.0.0.1:5000/users');
  xhr.send();
}

function update_interface() {
    const xhr = new XMLHttpRequest();

    xhr.onreadystatechange = () => {
      if (xhr.readyState == 4) {
        let data = JSON.parse(xhr.responseText);
        console.log("[+] Need update: " + data.need_update);
        if (data.need_update) {
          update();
        }
      }

    }
    xhr.open('GET', 'http://127.0.0.1:5000/users/need_update');
    xhr.send();
}

async function main() {
  while (1) {

    update_interface()
    await sleep(10000);
  }
}
