module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

  wire sum_of_products;
  wire product_of_sums;
  
  assign out_sop = sum_of_products;
  assign out_pos = product_of_sums;
  
  assign sum_of_products = (a & !b & !c & !d) | (!a & !b & c & !d) | (!a & !b & !c & d);
  assign product_of_sums = (!a & !b & !c & !d) & (!a & !b & c & !d) & (!a & !b & !c & d);
  
endmodule
