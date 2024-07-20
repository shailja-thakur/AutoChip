module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] y_counter;
	
	localparam A = 3'b000,
			   B = 3'b001,
			   C = 3'b010,
			   D = 3'b011,
			   E = 3'b100,
			   F = 3'b101;
			   
	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = resetn ? B : A;
			B: next_state = C;
			C: next_state = (x == 1) ? D : C;
			D: next_state = (x == 0) ? E : C;
			E: next_state = (x == 1) ? F : C;
			F: next_state = (y == 1) ? F : (y_counter == 2) ? A : F;
			default: next_state = A;
		endcase
	end
	
	// Synchronous state and output updates
	always @(posedge clk) begin
		if (!resetn) begin
			state <= A;
			f <= 0;
			g <= 0;
			y_counter <= 0;
		end else begin
			state <= next_state;
			case (state)
				A: f <= 0;
				B: f <= 1;
				C: f <= 0;
				D: f <= 0;
				E: f <= 0;
				F: begin
					f <= 0;
					if (next_state == A)
						g <= 0;
					else if (y == 1)
						g <= 1;
					else
						y_counter <= y_counter + 1;
				end
			endcase
		end
	end

endmodule
