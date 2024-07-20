module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b1;  // Reset state to B when areset is high
		else
			state <= in ? state : ~state;  // Update state based on input 'in'
	end
	
	assign out = (state == 2'b1);  // Output is high when state is B, low otherwise

endmodule
