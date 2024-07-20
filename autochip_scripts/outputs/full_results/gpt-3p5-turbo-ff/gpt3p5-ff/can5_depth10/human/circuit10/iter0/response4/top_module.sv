module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg d;
  always @(posedge clk) begin
    if (state == 1'b0) begin
      d <= a & b;
    end else begin
      d <= a | b;
    end
  end
  
  always @(posedge clk) begin
    if (state == 1'b0) begin
      q <= d;
    end else begin
      q <= ~d;
    end
  end
  
  always @(posedge clk) begin
    if (d == 1'b0 && state == 1'b0) begin
      state <= 1'b1;
    end else if (d == 1'b1 && state == 1'b1) begin
      state <= 1'b0;
    end
  end

endmodule
