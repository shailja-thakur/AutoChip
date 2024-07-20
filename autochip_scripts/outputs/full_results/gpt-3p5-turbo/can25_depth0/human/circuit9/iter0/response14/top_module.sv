module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

reg [2:0] state;

always @(posedge clk) begin
	case (state)
		3'b000:
			if (a)
				state <= 3'b001;
		3'b001:
			if (!a)
				state <= 3'b010;
		3'b010:
			if (a)
				state <= 3'b011;
				q <= 3'b100;
		3'b011:
			if (!a)
				state <= 3'b100;
				q <= 3'b100;
		3'b100:
			if (a)
				state <= 3'b101;
		3'b101:
			if (!a)
				state <= 3'b110;
		3'b110:
			if (a)
				state <= 3'b111;
		3'b111:
			state <= 3'b000;
			q <= 3'b000;
	endcase
end

endmodule
