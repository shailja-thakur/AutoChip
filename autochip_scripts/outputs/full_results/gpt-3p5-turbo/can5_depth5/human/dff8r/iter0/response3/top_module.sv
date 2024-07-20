module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_temp; // temporary register to store DFF outputs
	
	always @(posedge clk) begin
		if(reset) begin
			q_temp <= 8'b0; // reset the temporary register
		end
		else begin
			for(int i=0; i<8; i=i+1) begin
				q_temp[i] <= d[i]; // store the input values into the temporary register
			end
		end
	end
	
	always @(*) begin
		q <= q_temp; // assign the temporary register values to the output
	end
	
endmodule
