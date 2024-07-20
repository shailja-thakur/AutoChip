module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	// Reg for state
	reg [1:0] state;
	
	// Combinational logic for next state
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 2'b00; // State A
		else begin
			if (state == 2'b00) // State A
				state <= (j) ? 2'b10 : 2'b00;
			else // State B
				state <= (k) ? 2'b00 : 2'b10;
		end
	end
	
	// Assign output based on state
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
		
endmodule
