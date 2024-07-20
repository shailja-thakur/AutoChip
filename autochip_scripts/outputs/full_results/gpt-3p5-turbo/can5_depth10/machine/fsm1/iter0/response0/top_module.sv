module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  reg state;
  
  always @(posedge clk, posedge areset) begin
    if (areset)
      state <= 0;
    else if (state == 0) begin
      if (in)
        state <= 0;
      else
        state <= 1;
    end else begin
      if (in)
        state <= 1;
      else
        state <= 0;
    end
  end

  assign out = (state == 1) ? 1'b0 : 1'b1;

endmodule
