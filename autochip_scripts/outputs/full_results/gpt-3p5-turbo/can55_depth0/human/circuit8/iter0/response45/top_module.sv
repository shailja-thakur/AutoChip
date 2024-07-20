module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg [1:0] state;

always @(posedge clock) begin
	case (state)
		0: begin
			if (a == 1'b0) begin
				p <= 1'b0;
				q <= 1'b0;
				state <= 1;
			end
		end
		1: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b1)
				state <= 2;
		end
		2: begin
			p <= 1'b1;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 3;
		end
		3: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b1)
				state <= 4;
		end
		4: begin
			p <= 1'b1;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 5;
		end
		5: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 6;
		end
		6: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b1)
				state <= 7;
		end
		7: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 8;
		end
		8: begin
			p <= 1'b1;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 9;
		end
		9: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b1)
				state <= 10;
		end
		10: begin
			p <= 1'b1;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 11;
		end
		11: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b1)
				state <= 12;
		end
		12: begin
			p <= 1'b1;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 13;
		end
		13: begin
			p <= 1'b0;
			q <= 1'b1;
			if (a == 1'b0)
				state <= 14;
		end
		14: begin
			p <= 1'b0;
			q <= 1'b1;
			if (a == 1'b0)
				state <= 15;
		end
		15: begin
			p <= 1'b0;
			q <= 1'b1;
			if (a == 1'b0)
				state <= 16;
		end
		16: begin
			p <= 1'b0;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 17;
		end
		17: begin
			p <= 1'b0;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 18;
		end
		18: begin
			p <= 1'b1;
			q <= 1'b1;
			if (a == 1'b1)
				state <= 19;
		end
		19: begin
			p <= 1'b0;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 20;
		end
		20: begin
			p <= 1'b1;
			q <= 1'b0;
			if (a == 1'b0)
				state <= 0;
		end
	endcase
end

endmodule
