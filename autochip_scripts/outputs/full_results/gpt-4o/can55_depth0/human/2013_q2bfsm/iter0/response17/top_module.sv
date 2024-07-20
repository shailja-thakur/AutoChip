module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] counter;
	localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(posedge clk) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
			counter <= 0;
		end else begin
			case (state)
				A: begin
					f <= 0;
					g <= 0;
					counter <= 0;
					f <= 1;  // Set f to 1 for one clock cycle
				end
				
				B: begin
					f <= 0;  // Deassert f after one clock cycle
					if (x == 1)
						counter <= 1;
				end
				
				C: begin
					if (counter == 1 && x == 0)
						counter <= 2;
				end
				
				D: begin
					if (counter == 2 && x == 1) begin
						counter <= 0;
						g <= 1;  // Set g to 1 when x sequence 1, 0, 1 is detected
					end
				end
				
				E: begin
					if (y == 1)
						counter <= 0;
					else
						counter <= counter + 1;
				end
				
				F: begin
					if (counter == 1)
						g <= 0;
					else
						g <= 1;
				end

				default: state <= A;
			endcase
		end
	end

	always @(*) begin
		case (state)
			A: next_state = (!resetn) ? A : B;
			B: next_state = (x == 1) ? C : B;
			C: next_state = (x == 0) ? D : B;
			D: next_state = (x == 1) ? E : B;
			E: next_state = (y == 1) ? F : E;
			F: next_state = (!resetn) ? A : F;
			default: next_state = A;
		endcase
	end

endmodule
