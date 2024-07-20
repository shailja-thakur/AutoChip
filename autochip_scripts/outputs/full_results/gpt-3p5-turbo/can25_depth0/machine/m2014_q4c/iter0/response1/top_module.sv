module register (
  input clock,
  input data,
  input reset,
  output logic q
);

  always_ff @(posedge clock or posedge reset) begin
    if (reset)
      q <= 0;
    else
      q <= data;
  end

endmodule
module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  register reg (
    .clock(clk),
    .data(d),
    .reset(r),
    .q(q)
  );

endmodule
