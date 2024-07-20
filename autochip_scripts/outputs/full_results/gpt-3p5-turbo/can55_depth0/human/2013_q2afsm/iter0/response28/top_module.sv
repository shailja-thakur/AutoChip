module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define signals
reg [1:0] state;
reg g1, g2, g3;

// State transition and output logic
always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		state <= A;
		g1 <= 0;
		g2 <= 0;
		g3 <= 0;
	end else begin
		case(state)
			A: begin
				if (r[1] && !r[2] && !r[3])
					state <= D;
				else if (r[1] && !r[2] && r[3])
					state <= B;
				else if (!r[1] && r[2] && !r[3])
					state <= C;
				else
					state <= A;
			end
			B: begin
				if (r[1] && g1)
					state <= B;
				else if (r[1] && !g1)
					state <= A;
				else
					state <= B;
			end
			C: begin
				if (r[2] && g2)
					state <= C;
				else if (r[2] && !g2)
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

// Output assignment
always @(state) begin
	case(state)
		A: begin
			g1 = 1;
			g2 = 0;
			g3 = 0;
		end
		B: begin
			g1 = 1;
			g2 = 0;
			g3 = 0;
		end
		C: begin
			g1 = 0;
			g2 = 1;
			g3 = 0;
		end
		D: begin
			g1 = 0;
			g2 = 0;
			g3 = 1;
		end
	endcase
end

endmodule
