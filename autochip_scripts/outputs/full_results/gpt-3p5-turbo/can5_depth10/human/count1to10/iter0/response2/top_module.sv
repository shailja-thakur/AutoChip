module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

  // Internal signal to hold the intermediate count value
  reg [3:0] count;
  
  // Synchronous reset logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 4'b0001;
    end else begin
      count <= count + 1;
    end
  end
  
  // Output assignment
  assign q = count;
  
endmodule
