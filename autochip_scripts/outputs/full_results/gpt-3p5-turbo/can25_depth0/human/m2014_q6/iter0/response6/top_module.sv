module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state;
	reg [1:0] next_state;
	// state assignments
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// next state logic
	always @(state, w) begin
		case (state)
			A: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			
			B: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			
			C: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			
			D: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			end
			
			E: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			
			F: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
		endcase
	end
	
	// output logic
	always @(state) begin
		case (state)
			A, B, D: begin
				z = 1;
			end
			
			default: begin
				z = 0;
			end
		endcase
	end

endmodule
