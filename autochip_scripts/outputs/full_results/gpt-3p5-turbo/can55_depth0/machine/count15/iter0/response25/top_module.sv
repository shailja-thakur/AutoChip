module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
   
   // Declare a reg variable for the counter
   reg [3:0] counter;

   // Always block triggered on the rising edge of clk
   always @(posedge clk) begin
      // Check if reset is asserted
      if (reset)
         counter <= 0; // Reset the counter to 0
      else
         counter <= counter + 1; // Increment the counter by 1
      
      // Store the counter value in the output register q
      q <= counter;
   end
endmodule
