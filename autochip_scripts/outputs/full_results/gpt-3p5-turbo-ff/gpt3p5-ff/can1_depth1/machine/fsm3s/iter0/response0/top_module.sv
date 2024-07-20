module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if (in == 1) begin
						state <= B;
					end
				end
				B: begin
					if (in == 1) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				C: begin
					if (in == 1) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				D: begin
					if (in == 1) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				default: state <= A;
			endcase
		end
	end

	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
