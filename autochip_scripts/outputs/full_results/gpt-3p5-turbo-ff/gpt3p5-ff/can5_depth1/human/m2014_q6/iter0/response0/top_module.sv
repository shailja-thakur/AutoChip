module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;

	// Declare the states as parameters
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else if (state == A) begin
			if (w)
				state <= A; // A (0) --1--> A
			else
				state <= B; // A (0) --0--> B
		end else if (state == B) begin
			if (w)
				state <= D; // B (0) --1--> D
			else
				state <= C; // B (0) --0--> C
		end else if (state == C) begin
			if (w)
				state <= D; // C (0) --1--> D
			else
				state <= E; // C (0) --0--> E
		end else if (state == D) begin
			if (w)
				state <= A; // D (0) --1--> A
			else
				state <= F; // D (0) --0--> F
		end else if (state == E) begin
			if (w)
				state <= D; // E (1) --1--> D
			else
				state <= E; // E (1) --0--> E
		end else if (state == F) begin
			if (w)
				state <= D; // F (1) --1--> D
			else
				state <= C; // F (1) --0--> C
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b0;
			D: z = 1'b0;
			E: z = 1'b1;
			F: z = 1'b1;
		endcase
	end

endmodule
