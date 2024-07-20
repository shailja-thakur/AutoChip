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

	// State transitions
	always @(*) begin
		case (state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S4; else next_state = S1;
			S2: if (x) next_state = S1; else next_state = S2;
			S3: if (x) next_state = S2; else next_state = S1;
			S4: if (x) next_state = S4; else next_state = S3;
			default: next_state = S0;
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			S3, S4: z = 1;
			default: z = 0;
		endcase
	end

endmodule
