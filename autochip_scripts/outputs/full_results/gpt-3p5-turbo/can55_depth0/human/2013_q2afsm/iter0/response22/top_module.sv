module fsm (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

	parameter A = 2'b00; // State A
	parameter B = 2'b01; // State B
	parameter C = 2'b10; // State C
	parameter D = 2'b11; // State D

	reg [1:0] state;
	reg [3:1] grant;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if (r[1] && (!r[2]) && (!r[3]))
						state <= B;
					else if ((!r[1]) && r[2] && (!r[3]))
						state <= C;
					else if ((!r[1]) && (!r[2]) && (!r[3]))
						state <= D;
				end
				B: begin
					if (r[1])
						state <= B;
					else
						state <= A;
				end
				C: begin
					if (r[2])
						state <= C;
					else
						state <= A;
				end
				D: begin
					if (r[1] && (!r[2]) && (!r[3]))
						state <= A;
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
			A: begin
				grant = 3'b000;
			end
			B: begin
				grant = 3'b100;
			end
			C: begin
				grant = 3'b010;
			end
			D: begin
				grant = 3'b000;
			end
		endcase
	end

	assign g = grant;

endmodule
module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

	fsm fsm_inst (
		.clk(clk),
		.resetn(resetn),
		.r(r),
		.g(g)
	);

endmodule
