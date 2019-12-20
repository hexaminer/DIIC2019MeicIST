function getRequest(url) {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', url);
  
  xhr.onreadystatechange = () => {
    console.log(xhr.responseText);
  }

  xhr.send();
}

// values format "foo=bar&lorem=ipsum"
function postRequest(url, values) {
  const xhr = new XMLHttpRequest();
  xhr.open("POST", url);

  // Send the proper header information along with the request
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

  xhr.onreadystatechange = () => {
    if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
      console.log(xhr.responseText);
    }
  }

  xhr.send(values);

}

getRequest('http://127.0.0.1:5000/users');
