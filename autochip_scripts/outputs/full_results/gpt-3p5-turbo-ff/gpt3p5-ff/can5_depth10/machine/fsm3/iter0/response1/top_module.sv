module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// state machine states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			out_reg <= 0;
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B;
						out_reg <= 0;
					end else begin
						state <= A;
						out_reg <= 0;
					end
				end
				B: begin
					if (in) begin
						state <= B;
						out_reg <= 0;
					end else begin
						state <= C;
						out_reg <= 0;
					end
				end
				C: begin
					if (in) begin
						state <= D;
						out_reg <= 0;
					end else begin
						state <= A;
						out_reg <= 0;
					end
				end
				D: begin
					if (in) begin
						state <= B;
						out_reg <= 1;
					end else begin
						state <= C;
						out_reg <= 0;
					end
				end
			endcase
		end
	end

	assign out = out_reg;

endmodule
