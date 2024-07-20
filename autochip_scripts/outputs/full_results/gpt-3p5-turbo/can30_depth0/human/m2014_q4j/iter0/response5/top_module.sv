module top_module(
  input [3:0] x,
  input [3:0] y,
  output reg [4:0] sum
);

  wire [3:0] carry;
  
  // Instantiate four full adders
  full_adder fa0(x[0], y[0], 0, sum[0], carry[0]);
  full_adder fa1(x[1], y[1], carry[0], sum[1], carry[1]);
  full_adder fa2(x[2], y[2], carry[1], sum[2], carry[2]);
  full_adder fa3(x[3], y[3], carry[2], sum[3], sum[4]);

  // Output overflow = carry out of the last full adder
  assign sum[4] = carry[3];
  
endmodule
module full_adder(
  input a,
  input b,
  input cin,
  output reg sum,
  output reg cout
);
  
  always @(a, b, cin) begin
    sum <= a ^ b ^ cin;
    cout <= (a & b) | (cin & (a ^ b));
  end
  
endmodule
