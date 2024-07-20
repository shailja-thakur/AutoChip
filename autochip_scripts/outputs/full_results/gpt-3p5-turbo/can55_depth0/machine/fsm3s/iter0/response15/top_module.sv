module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare the states
	parameter A = 0,
			  B = 1,
			  C = 2,
			  D = 3;

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				
				C: begin
					if (in) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				
				D: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end

	always @(*) begin
		if (state == D) begin
			out_reg = 1;
		end else begin
			out_reg = 0;
		end
	end

	assign out = out_reg;

endmodule
