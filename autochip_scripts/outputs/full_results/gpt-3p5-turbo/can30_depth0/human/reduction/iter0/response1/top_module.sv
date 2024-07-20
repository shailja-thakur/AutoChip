module top_module (
  input [7:0] in,
  output parity
);
  reg [7:0] in_reg;
  wire [7:0] in_xor;
  
  assign in_xor = ^in_reg;
  assign parity = ^in_xor;
  
  always @(in) begin
    in_reg <= in;
  end

endmodule
