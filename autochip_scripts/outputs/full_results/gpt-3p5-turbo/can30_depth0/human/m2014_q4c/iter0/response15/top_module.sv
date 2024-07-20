module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

logic q_reg;
always @(posedge clk) begin
  if (r) begin // active-high reset
    q_reg <= 0;
  end else begin
    q_reg <= d;
  end
end

assign q = q_reg;

endmodule
