module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

reg [1:0] state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= A;
		g <= 3'b000;
	end
	else begin
		case (state)
			A: begin
				if (r[1] == 1'b1)
					state <= B;
				else if (r[2] == 1'b1)
					state <= C;
				else if (r[3] == 1'b1)
					state <= D;
			end
			B: begin
				if (r[1] == 1'b1)
					state <= B;
				else
					state <= A;
			end
			C: begin
				if (r[2] == 1'b1)
					state <= C;
				else
					state <= A;
			end
			D: begin
				state <= A;
			end
		endcase
	end
end

always @(state) begin
	case (state)
		A: g <= 3'b000;
		B: g <= {1'b1, 1'b0, 1'b0};
		C: g <= {1'b0, 1'b1, 1'b0};
		D: g <= {1'b0, 1'b0, 1'b1};
	endcase
end

endmodule
