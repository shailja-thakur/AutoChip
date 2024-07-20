module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	reg [1:0] state;
	always @(posedge clk, negedge areset)
		if (!areset)
			state <= 2'b00;
		else
			state <= next_state;
			z <= out;
	
	assign next_state = state + 1;
	assign out = ~x + 1;
endmodule
