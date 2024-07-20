module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
	reg [1:0] state, next_state;
	
	// State flip-flops (sequential logic)
	always @(posedge clk) begin
		if (!resetn)
			state <= A; // Reset to the initial state A
		else
			state <= next_state; // Transition to the next state
	end
	
	// State table (combinational logic)
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
				if (r[1])
					next_state = B;
				else
					next_state = A;
			end
			C: begin
				if (r[2])
					next_state = C;
				else
					next_state = A;
			end
			D: begin
				if (r[3])
					next_state = D;
				else
					next_state = A;
			end
			default: next_state = A;
		endcase
	end
	
	// Output logic (using an always block for synchronous updates)
	always @(posedge clk) begin
		if (!resetn) begin
			g <= 3'b000;
		end else begin
			case (state)
				B: g <= 3'b001;
				C: g <= 3'b010;
				D: g <= 3'b100;
				default: g <= 3'b000;
			endcase
		end
	end

endmodule
