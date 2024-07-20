module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

// Counter signal
reg [9:0] counter;
  
always @(posedge clk) begin
  if (reset)
    counter <= 0;
  else if (counter == 10'b1111100111) // Use 10 bits for comparison
    counter <= 0;
  else
    counter <= counter + 1;
end

assign q = counter;

endmodule
