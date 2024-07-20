module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1'b1) begin
		case(q)
			3'b000: q <= 3'b100;
			3'b100: begin
				if(q==3'b100)
					q <= 3'b101;
				else
					q <= q;
			end
			3'b101: q <= 3'b101;
			default: q <= 3'b000;
		endcase
	end else begin
		q <= q;
	end
end

endmodule
