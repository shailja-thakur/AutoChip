module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// internal state signals
	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b001; // initialize state to A
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			3'b000: if (x) next_state = 3'b010; else next_state = 3'b000; // A
			3'b001: if (x) next_state = 3'b010; else next_state = 3'b001; // B
			3'b010: if (x) next_state = 3'b001; else next_state = 3'b010; // C
			3'b011: if (x) next_state = 3'b010; else next_state = 3'b001; // D
			3'b100: if (x) next_state = 3'b100; else next_state = 3'b011; // E
			3'b101: if (x) next_state = 3'b100; else next_state = 3'b101; // F
			3'b110: if (x) next_state = 3'b101; else next_state = 3'b110; // G
			3'b111: if (x) next_state = 3'b110; else next_state = 3'b111; // H
		endcase
	end

	always @(state) begin
		case (state)
			3'b001: z = 1'b1; // D
			3'b100: z = 1'b1; // E
			default: z = 1'b0;
		endcase
	end

endmodule
