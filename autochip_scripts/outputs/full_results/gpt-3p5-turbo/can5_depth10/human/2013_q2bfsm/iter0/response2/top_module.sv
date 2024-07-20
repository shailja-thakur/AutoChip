module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state, next_state;

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
			f <= 0;
			g <= 0;
		end else begin
			state <= next_state;
			f <= 0;
			g <= 0;
			case (state)
				A: begin
					if (resetn == 1) begin
						if (x == 1) begin
							next_state <= B;
						end else begin
							next_state <= A;
						end
					end else begin
						if (resetn == 0) begin
							next_state <= A;
						end
					end
				end
				B: begin
					if (resetn == 1) begin
						f <= 1;
						next_state <= C;
					end else begin
						if (resetn == 0) begin
							next_state <= A;
						end
					end
				end
				C: begin
					if (resetn == 1) begin
						if (x == 1) begin
							next_state <= D;
						end else begin
							next_state <= C;
						end
					end else begin
						if (resetn == 0) begin
							next_state <= A;
						end
					end
				end
				D: begin
					if (resetn == 1) begin
						if (y == 1) begin
							g <= 1;
							next_state <= D;
						end else begin
							g <= 0;
							next_state <= A;
						end
					end else begin
						if (resetn == 0) begin
							next_state <= A;
						end
					end
				end
				default: next_state <= A;
			endcase
		end
	end
endmodule
