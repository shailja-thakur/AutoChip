module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_reg;
reg state_reg;
reg state_next;

always @(posedge clk) begin
  state_reg <= state_next;
  q_reg <= state_reg;
end

always @(*) begin
  state_next = (a & b);
end

always @(posedge clk) begin
  if (state_reg == 1'b1) begin
    q <= 1'b1;
  end else begin
    q <= 1'b0;
  end
end

always @(posedge clk) begin
  if (state_reg == 1'b1) begin
    state <= 1'b1;
  end else begin
    state <= 1'b0;
  end
end

endmodule
