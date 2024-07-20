module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  always_ff @(posedge clk or posedge r) begin
    if (r) begin
      q <= 1'b0;
    end else if (d) begin
      q <= d;
    end else begin
      q <= q;
    end
  end

endmodule
