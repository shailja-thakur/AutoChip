module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;
	
	// State encoding
	localparam S0 = 3'b000;
	localparam S1 = 3'b001;
	localparam S2 = 3'b010;
	localparam S3 = 3'b011;
	localparam S4 = 3'b100;

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Combinational logic for next state and output
	always @(state, x) begin
		case (state)
			S0: begin
				next_state = (x) ? S1 : S0;
				z = 0;
			end
			S1: begin
				next_state = (x) ? S4 : S1;
				z = 0;
			end
			S2: begin
				next_state = (x) ? S1 : S2;
				z = 0;
			end
			S3: begin
				next_state = (x) ? S2 : S1;
				z = 1;
			end
			S4: begin
				next_state = (x) ? S4 : S3;
				z = 1;
			end
			default: begin
				next_state = S0;
				z = 0;
			end
		endcase
	end

endmodule
