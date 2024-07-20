module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

  wire [1:0] sum_temp;
  wire cout_temp;
  
  assign sum_temp = a + b + cin;  // Calculation of sum_temp
  
  assign cout_temp = sum_temp >= 2 ? 1'b1 : 1'b0;  // Calculation of cout_temp
  
  assign cout = cout_temp;  // Assigns cout_temp to cout
  assign sum = sum_temp[0];  // Assigns the least significant bit of sum_temp to sum
  
endmodule
