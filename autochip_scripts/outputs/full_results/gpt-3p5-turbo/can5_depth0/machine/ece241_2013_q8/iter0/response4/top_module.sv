module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [3:0] state, next_state;

	parameter S = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S10 = 4'b0010;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case ({x, state})
			2'b00: next_state = S;
			2'b01: next_state = S1;
			2'b10: next_state = S10;
			2'b11: next_state = S1;
			default: next_state = state;
		endcase
	end

	always @(state) begin
		case (state)
			S: z = 1'b0;
			S1: z = 1'b0;
			S10: z = x;
			default: z = 1'b0;
		endcase
	end
endmodule
