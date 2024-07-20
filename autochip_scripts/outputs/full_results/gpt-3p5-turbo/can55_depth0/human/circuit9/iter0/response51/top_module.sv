module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if(a == 1'b1) begin
		case(q)
			3'b000: q <= 3'b100;
			3'b100: q <= 3'b010;
			3'b010: q <= 3'b001;
			default: q <= 3'b000;
		endcase
	end
	else begin
		q <= q;
	end
end

endmodule
