module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1) begin
		case (q)
			3'b000: q <= 3'b001;
			3'b001: q <= 3'b010;
			3'b010: q <= 3'b011;
			default: q <= 3'b000;
		endcase
	else
		q <= 3'b100;
	end
end

endmodule
