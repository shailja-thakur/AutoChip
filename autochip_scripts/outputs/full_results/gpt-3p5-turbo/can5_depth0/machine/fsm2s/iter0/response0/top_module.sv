module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	// internal signal for the current state
	reg [1:0] state;
	
	// output assignment
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
	
	// state transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else if (state == 2'b00)
			state <= (j) ? 2'b10 : 2'b00;
		else if (state == 2'b10)
			state <= (k) ? 2'b00 : 2'b10;
	end
	
endmodule
