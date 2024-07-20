module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	case(q)
		3'b000: begin
			if (a)
				q <= 4;
		end
		3'b001: begin
			if (a)
				q <= 4;
			else
				q <= 0;
		end
		3'b100: begin
			if (a)
				q <= 4;
			else
				q <= 5;
		end
		3'b101: begin
			if (a)
				q <= 4;
			else
				q <= 6;
		end
		3'b110: begin
			if (a)
				q <= 4;
			else
				q <= 0;
		end
		3'b111: begin
			if (a)
				q <= 5;
			else
				q <= 1;
		end
		default: q <= 0;
	endcase
end

endmodule
