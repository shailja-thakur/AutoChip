module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

// Counter signal
reg [9:0] counter;
  
always @(posedge clk) begin
  if (reset)
    counter <= 0;
  else if (counter == 9'h3E7)
    counter <= 0;
  else
    counter <= counter + 1;
end

assign q = counter;

endmodule
