module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 2'b01;
    else if (state == 2'b01 && in)
      state <= 2'b10;
    else if (state == 2'b10 && !in)
      state <= 2'b01;
  end
  
  always @(posedge clk) begin
    if (reset)
      out <= 1'b1;
    else
      out <= (state == 2'b10);
  end
  
endmodule
