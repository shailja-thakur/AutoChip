module top_module (
    input clk,
    input x,
    output z
);

reg d_ff1;
reg d_ff2;
reg d_ff3;

wire x_xor_d_ff1;
wire x_and_d_ff2;
wire x_or_d_ff3;

wire z;

assign x_xor_d_ff1 = x ^ d_ff1;
assign x_and_d_ff2 = x & ~d_ff2;
assign x_or_d_ff3 = x | ~d_ff3;

xor #(3) xnor (
  .in1(x_xor_d_ff1),
  .in2(x_and_d_ff2),
  .in3(x_or_d_ff3),
  .out(z)
);

always @(posedge clk) begin
    d_ff1 <= x_xor_d_ff1;
    d_ff2 <= x_and_d_ff2;
    d_ff3 <= x_or_d_ff3;
end

endmodule
