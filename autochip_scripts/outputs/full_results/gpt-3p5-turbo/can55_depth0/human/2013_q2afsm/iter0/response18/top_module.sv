module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [1:0] state;
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else begin
			case (state)
				A: begin
					if (r[1] == 1'b1)
						state <= B;
					else if (r[2] == 1'b1)
						state <= C;
					else if (r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0)
						state <= D;
					else
						state <= A;
				end

				B: begin
					if (r[1] == 1'b1)
						state <= B;
					else if (r[1] == 1'b0)
						state <= A;
					else
						state <= B;
				end

				C: begin
					if (r[2] == 1'b1)
						state <= C;
					else if (r[2] == 1'b0)
						state <= A;
					else
						state <= C;
				end

				D: begin
					state <= A;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (state)
			A: g <= 3'b000;
			B: g <= 3'b001;
			C: g <= 3'b010;
			D: g <= 3'b111;
		endcase
	end
endmodule
