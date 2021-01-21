function rate (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input",() => {
    const inputValue = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${[Math.floor(inputValue * 0.1)].toLocaleString()}`;
    const profit = document.getElementById("profit");
    profit.innerHTML = `${[Math.floor(inputValue * 0.9)].toLocaleString()}`;
  });
}

window.addEventListener("load",rate)