module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t state, next_state;

	// State flip-flops
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
		end

	// Next state logic (state table)
	always @(*) begin
		case (state)
			A: begin
				if (r[1] == 1)
					next_state = B;
				else if (r[2] == 1)
					next_state = C;
				else
					next_state = D;
			end
			B: begin
				if (r[1] == 0)
					next_state = A;
				else
					next_state = B;
			end
			C: begin
				if (r[2] == 0)
					next_state = A;
				else 
					next_state = C;
			end
			D: next_state = A;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(*) begin
		g = 3'b000;  // Default to no grants
		case (state)
			B: g[1] = 1;
			C: g[2] = 1;
			D: g[3] = 1;
			default: g = 3'b000;
		endcase	
	end
	
endmodule
