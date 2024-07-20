module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state, next_state;
	
	parameter A = 3'd0;
	parameter B = 3'd1;
	parameter C = 3'd2;
	parameter D = 3'd3;
	parameter E = 3'd4;
	parameter F = 3'd5;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case(state)
			A: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			C: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			D: begin
				if (w) begin
					next_state = F;
				end else begin
					next_state = A;
				end
			end
			E: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			F: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
		endcase
	end
	
	always @(state) begin
		case(state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b1;
			D: z = 1'b0;
			E: z = 1'b0;
			F: z = 1'b1;
		endcase
	end
endmodule
