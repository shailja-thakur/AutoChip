module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [3:0] state, next_state;

parameter S = 4'b000, S1 = 4'b001, S10 = 4'b010;

always @(posedge clk or negedge aresetn)
begin
	if (~aresetn) begin
		state <= S;
	end
	else begin
		state <= next_state;
	end
end

always @(*)
begin
	case (state)
		S: begin
			if (x == 1)
				next_state = S1;
			else
				next_state = S;
		end
		S1: begin
			if (x == 0)
				next_state = S10;
			else
				next_state = S1;
		end
		S10: begin
			if (x == 1)
				next_state = S1;
			else
				next_state = S;
		end
		default: next_state = S;
	endcase
end

always @(*)
begin
	case (state)
		S: z = 0;
		S1: z = 0;
		S10: z = x;
		default: z = 0;
	endcase
end

endmodule
