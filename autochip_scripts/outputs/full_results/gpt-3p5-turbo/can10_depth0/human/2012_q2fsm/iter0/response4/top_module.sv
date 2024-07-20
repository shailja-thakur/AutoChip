module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State Codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	// State Transition Logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Next State Logic
	always @(*) begin
		case (state)
			A: begin
				if (w == 1'b1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w == 1'b1) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			C: begin
				if (w == 1'b1) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			D: begin
				if (w == 1'b1) begin
					next_state = F;
				end else begin
					next_state = A;
				end
			end
			E: begin
				if (w == 1'b1) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			F: begin
				if (w == 1'b1) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			default: next_state = A;
		endcase
	end
	
	// Output Logic
	assign z = (state == E || state == F) ? 1'b1 : 1'b0;
		
endmodule
