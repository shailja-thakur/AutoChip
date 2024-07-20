module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg q;
  reg q_next;
  
  always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
      q <= 0;
    end else begin
      q <= q_next;
    end
  end
  
  always @(clk, areset, x) begin
    if (areset == 0) begin
      q_next <= 0;
    end else begin
      q_next <= x ^ 1'b1;
    end
  end

  assign z = q;

endmodule
