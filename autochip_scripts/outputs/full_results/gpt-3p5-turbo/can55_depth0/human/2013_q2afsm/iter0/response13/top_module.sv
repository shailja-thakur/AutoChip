module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [2:0] state;
reg [3:1] g;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always@(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= A;
	else begin
		case(state)
			A: begin
				if (r[3:1] == 3'b000)
					state <= A;
				else if (r[1] == 1'b1)
					state <= B;
				else if (r[1] == 1'b0 && r[2] == 1'b1)
					state <= C;
				else if (r[1] == 1'b0 && r[2] == 1'b0 && r[3:1] == 3'b000)
					state <= D;
			end
			
			B: begin
				if (r[1] == 1'b1 && g[1] == 1'b1)
					state <= B;
				else if (r[1] == 1'b0)
					state <= A;
			end
			
			C: begin
				if (r[2] == 1'b1 && g[2] == 1'b1)
					state <= C;
				else if (r[2] == 1'b0)
					state <= A;
			end
			
			D: begin
				if (r[3:1] == 3'b000)
					state <= A;
			end
		endcase
	end
end

always@(posedge clk or negedge resetn) begin
	if (~resetn)
		g <= 3'b000;
	else begin
		case (state)
			A: g <= 3'b000;
			B: g <= 3'b001;
			C: g <= 3'b010;
			D: g <= 3'b011;
		endcase
	end
end

endmodule
