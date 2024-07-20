module top_module(
  input clk,
  input reset,
  output reg [3:0] q);
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 4'b0001;       // reset the counter to 1
    end else begin
      if (q == 4'b1010)   // check if the counter has reached 10
        q <= 4'b0001;     // reset the counter to 1
      else
        q <= q + 1;       // increment the counter
    end
  end
  
endmodule
