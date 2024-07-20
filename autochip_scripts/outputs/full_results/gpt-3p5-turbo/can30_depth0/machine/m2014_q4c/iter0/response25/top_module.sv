module top_module (
  input clk,
  input d,
  input r,
  output logic q
);
  always_ff @(posedge clk or posedge r) begin
    if (r)
      q <= 0;
    else
      q <= d;
  end
endmodule
