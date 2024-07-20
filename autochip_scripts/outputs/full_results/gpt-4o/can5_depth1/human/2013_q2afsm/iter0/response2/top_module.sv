module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	typedef enum reg [1:0] {A=2'd0, B=2'd1, C=2'd2, D=2'd3} state_t;
	state_t state, next_state;

	// State transition block (edge-triggered always block for flip-flops)
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A; // reset to state A
		else
			state <= next_state;
	end

	// Next state logic block (combinational always block for state transitions)
	always @(*) begin
		case (state)
			A: begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
				else
					next_state = A;
			end
			B: begin
				if (!r[1])
					next_state = A;
				else
					next_state = B;
			end
			C: begin
				if (!r[2])
					next_state = A;
				else
					next_state = C;
			end
			D: begin
				if (!r[3])
					next_state = A;
				else
					next_state = D;
			end
			default: next_state = A; // Default case to avoid latches
		endcase
	end

	// Output logic block
	always @(*) begin
		case (state)
			A: g = 3'b000; // no grants
			B: g = 3'b001; // grant to device 1
			C: g = 3'b010; // grant to device 2
			D: g = 3'b100; // grant to device 3
			default: g = 3'b000; // no grants
		endcase
	end

endmodule
