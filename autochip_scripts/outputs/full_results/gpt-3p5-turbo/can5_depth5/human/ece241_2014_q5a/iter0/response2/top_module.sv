module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or negedge areset) begin
	if (!areset)
		state <= 3'b000;
	else begin
		case(state)
			3'b000: if (x == 1'b1) state <= 3'b001; else state <= 3'b000;
			3'b001: if (x == 1'b1) state <= 3'b010; else state <= 3'b001;
			3'b010: if (x == 1'b1) state <= 3'b011; else state <= 3'b010;
			3'b011: if (x == 1'b1) state <= 3'b001; else state <= 3'b100;
			3'b100: if (x == 1'b1) state <= 3'b101; else state <= 3'b100;
			3'b101: if (x == 1'b1) state <= 3'b110; else state <= 3'b101;
			3'b110: if (x == 1'b1) state <= 3'b111; else state <= 3'b110;
			3'b111: if (x == 1'b1) state <= 3'b001; else state <= 3'b000;
		endcase
	end
end

always @(*) begin
	case(state)
		3'b000: z = 1'b0;
		3'b001: z = ~x;
		3'b010: z = ~x + 1'b1;
		3'b011: z = ~x + 1'b1;
		3'b100: z = ~x;
		3'b101: z = ~x + 1'b1;
		3'b110: z = ~x + 1'b1;
		3'b111: z = ~x + 1'b1;
	endcase
end

endmodule
