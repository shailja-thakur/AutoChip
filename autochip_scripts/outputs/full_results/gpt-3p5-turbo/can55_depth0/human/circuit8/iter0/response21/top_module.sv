module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg [1:0] state;

always @(posedge clock) begin
	case(state)
		0: begin
			if (a == 0) begin
				state <= 1;
				p <= 0;
				q <= x;
			end else begin
				state <= 2;
				p <= 1;
				q <= x;
			end
		end
		1: begin
			if (a == 0) begin
				state <= 1;
				p <= 0;
				q <= x;
			end else begin
				state <= 3;
				p <= 1;
				q <= x;
			end
		end
		2: begin
			if (a == 0) begin
				state <= 2;
				p <= 0;
				q <= x;
			end else begin
				state <= 3;
				p <= 1;
				q <= x;
			end
		end
		3: begin
			state <= 0;
			p <= 0;
			q <= 0;
		end
	endcase
end

endmodule
