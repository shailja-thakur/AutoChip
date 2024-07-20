module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg [1:0] state;
reg q;

always @(posedge clk) begin
	case(state)
		0: if (a & ~b) begin
			state <= 0;
			q <= 0;
		end else if (~a & ~b) begin
			state <= 0;
			q <= 0;
		end else if (~a & b) begin
			state <= 1;
			q <= 1;
		end else if (a & ~b) begin
			state <= 1;
			q <= 1;
		end
		1: if (a & ~b) begin
			state <= 1;
			q <= 1;
		end else if (~a & ~b) begin
			state <= 1;
			q <= 1;
		end else if (~a & b) begin
			state <= 2;
			q <= 0;
		end else if (a & ~b) begin
			state <= 2;
			q <= 0;
		end
		2: if (a & ~b) begin
			state <= 2;
			q <= 0;
		end else if (~a & ~b) begin
			state <= 2;
			q <= 0;
		end else if (~a & b) begin
			state <= 3;
			q <= 1;
		end else if (a & ~b) begin
			state <= 3;
			q <= 1;
		end
		3: if (a & ~b) begin
			state <= 3;
			q <= 1;
		end else if (~a & ~b) begin
			state <= 3;
			q <= 1;
		end else if (~a & b) begin
			state <= 0;
			q <= 0;
		end else if (a & ~b) begin
			state <= 0;
			q <= 0;
		end
	endcase
end

assign state = q;

endmodule
