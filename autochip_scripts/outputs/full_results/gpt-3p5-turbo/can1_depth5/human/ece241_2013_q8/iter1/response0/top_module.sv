module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= S0;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case(state)
		S0: begin
			if (x == 1'b1)
				next_state = S1;
			else
				next_state = S0;
			z = 1'b0;
		end
		S1: begin
			if (x == 1'b0)
				next_state = S2;
			else
				next_state = S1;
			z = 1'b0;
		end
		S2: begin
			if (x == 1'b1) begin
				next_state = S1;
				z = 1'b1;
			end else if (x == 1'b0) begin
				next_state = S0;
				z = 1'b0;
			end
		end
		default: next_state = S0;
	endcase
end

endmodule
