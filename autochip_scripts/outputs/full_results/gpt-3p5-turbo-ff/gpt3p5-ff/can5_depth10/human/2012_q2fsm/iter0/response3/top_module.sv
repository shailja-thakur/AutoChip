module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	reg [1:0] state, next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state, w) begin
		case (state)
			A: begin
				if (w == 1'b0) begin
					next_state = A;
					z = 1'b0;
				end else begin
					next_state = B;
					z = 1'b0;
				end
			end
			B: begin
				if (w == 1'b0) begin
					next_state = D;
					z = 1'b0;
				end else begin
					next_state = C;
					z = 1'b0;
				end
			end
			C: begin
				if (w == 1'b0) begin
					next_state = D;
					z = 1'b0;
				end else begin
					next_state = E;
					z = 1'b1;
				end
			end
			D: begin
				if (w == 1'b0) begin
					next_state = A;
					z = 1'b0;
				end else begin
					next_state = F;
					z = 1'b0;
				end
			end
			E: begin
				if (w == 1'b0) begin
					next_state = D;
					z = 1'b1;
				end else begin
					next_state = E;
					z = 1'b1;
				end
			end
			F: begin
				if (w == 1'b0) begin
					next_state = D;
					z = 1'b0;
				end else begin
					next_state = C;
					z = 1'b0;
				end
			end
		endcase
	end

endmodule
