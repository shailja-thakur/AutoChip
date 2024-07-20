module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);

reg state;
reg q;

always @(posedge clk) begin
  if (state) begin
    q <= 1;
  end else begin
    if (a & ~b) begin
      state <= 1;
    end else begin
      state <= 0;
    end
    q <= 0;
  end
end

endmodule
