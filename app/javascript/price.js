 const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      
      // 販売手数料と販売利益を計算
      const tax = Math.floor(inputValue * 0.1);  // 10%の販売手数料
      const profit = inputValue - tax;

      // DOMに表示
      addTaxDom.innerHTML = tax.toLocaleString();
      profitDom.innerHTML = profit.toLocaleString();
    });
  }
});


window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);