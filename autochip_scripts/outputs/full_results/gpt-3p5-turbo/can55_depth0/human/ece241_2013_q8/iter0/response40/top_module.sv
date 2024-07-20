module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state, next_state;

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn)
		state <= S0;
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		S0: begin
			z <= 0;
			if (x)
				next_state <= S1;
			else
				next_state <= S0;
		end
		S1: begin
			if (x)
				next_state <= S2;
			else
				next_state <= S0;
		end
		S2: begin
			if (x)
				next_state <= S1;
			else begin
				next_state <= S0;
				z <= 1;
			end
		end
	endcase
end

endmodule
