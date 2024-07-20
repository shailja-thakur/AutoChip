module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
  
	reg [7:0] q_temp; // Temporary register to hold the output
  
	always@(posedge clk or areset) begin
		if (areset) begin
			q_temp <= 8'b0; // Reset the temporary register
		end else begin
			q_temp <= d; // Update the temporary register with input data
		end
	end
	
	always@(posedge clk) begin
		q <= q_temp; // Update the output register on positive edge of clk
	end
endmodule
