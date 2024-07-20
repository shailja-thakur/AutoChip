module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	// Declare state variables
	reg [1:0] state;
	reg [3:1] g_reg;

	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// State flip-flops
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
			g_reg <= 3'b000;
		end else begin
			case (state)
				A: begin
					if (r[1]) begin
						state <= B;
						g_reg <= 3'b001;
					end else if (r[2]) begin
						state <= C;
						g_reg <= 3'b010;
					end else if (r[3]) begin
						state <= D;
						g_reg <= 3'b000;
					end else begin
						state <= A;
						g_reg <= 3'b000;
					end
				end
				B: begin
					if (r[1]) begin
						state <= B;
						g_reg <= 3'b001;
					end else begin
						state <= A;
						g_reg <= 3'b000;
					end
				end
				C: begin
					if (r[2]) begin
						state <= C;
						g_reg <= 3'b010;
					end else begin
						state <= A;
						g_reg <= 3'b000;
					end
				end
				D: begin
					state <= A;
					g_reg <= 3'b000;
				end
			endcase
		end
	end

	// Output assignment
	assign g = g_reg;

endmodule
