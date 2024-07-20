module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [3:0] state;
reg [3:0] next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 4'b0000;
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		4'b0000: next_state = 4'b0001;
		4'b0001: next_state = 4'b0010;
		4'b0010: next_state = 4'b0011;
		4'b0011: next_state = 4'b0100;
		4'b0100: next_state = 4'b0101;
		4'b0101: next_state = 4'b0110;
		4'b0110: next_state = 4'b0111;
		4'b0111: next_state = 4'b1000;
		4'b1000: next_state = 4'b1001;
		4'b1001: next_state = 4'b1010;
		4'b1010: next_state = 4'b1011;
		4'b1011: next_state = 4'b1100;
		4'b1100: next_state = 4'b1101;
		4'b1101: next_state = 4'b1110;
		4'b1110: next_state = 4'b1111;
		4'b1111: next_state = 4'b0000;
	endcase
end

always @(state, x) begin
	case (state)
		4'b0000: z = 1'b0;
		4'b0001: z = ~x;
		4'b0010: z = 1'b0;
		4'b0011: z = ~x;
		4'b0100: z = 1'b1;
		4'b0101: z = ~x;
		4'b0110: z = 1'b1;
		4'b0111: z = ~x;
		4'b1000: z = 1'b0;
		4'b1001: z = ~x;
		4'b1010: z = 1'b0;
		4'b1011: z = ~x;
		4'b1100: z = 1'b1;
		4'b1101: z = ~x;
		4'b1110: z = 1'b1;
		4'b1111: z = ~x;
	endcase
end

endmodule
