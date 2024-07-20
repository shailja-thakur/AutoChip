module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	reg out;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			out <= 0;
		end else begin
			case(state)
				A: begin
					if (in) begin
						state <= B;
					end else begin
						state <= A;
					end
					out <= 0;
				end
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
					out <= 0;
				end
				C: begin
					if (in) begin
						state <= D;
					end else begin
						state <= A;
					end
					out <= 0;
				end
				D: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
					out <= 1;
				end
			endcase
		end
	end
endmodule
