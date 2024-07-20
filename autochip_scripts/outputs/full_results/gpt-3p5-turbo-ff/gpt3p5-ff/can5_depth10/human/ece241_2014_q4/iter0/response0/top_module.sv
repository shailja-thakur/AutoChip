module top_module (
	input clk,
	input x,
	output z
);

  reg dff0;
  reg dff1;
  reg dff2;
  wire x_xor_dff0;
  wire x_and_not_dff1;
  wire x_or_not_dff2;

  xor u0 (
    .a(x),
    .b(dff0),
    .o(x_xor_dff0)
  );

  and u1 (
    .a(x),
    .b(~dff1),
    .o(x_and_not_dff1)
  );

  or u2 (
    .a(x),
    .b(~dff2),
    .o(x_or_not_dff2)
  );

  xnor u3 (
    .a(x_xor_dff0),
    .b(x_and_not_dff1),
    .c(x_or_not_dff2),
    .o(z)
  );

  always @(posedge clk) begin
    dff0 <= x_xor_dff0;
    dff1 <= x_and_not_dff1;
    dff2 <= x_or_not_dff2;
  end

endmodule
