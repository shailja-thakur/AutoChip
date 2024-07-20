module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

wire [3:0] inputs;
wire output_xor;
wire output_inv;

assign inputs = {a, b, c, d};
assign output_xor = ^inputs;
assign output_inv = ~output_xor;

assign q = output_inv;

endmodule
