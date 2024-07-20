module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01;  // Set state to B on reset
		else
			state <= (state == 2'b00 && in) ? state : (~state); // Transition based on current state and input
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;  // Set output high when state is B, otherwise low
endmodule
