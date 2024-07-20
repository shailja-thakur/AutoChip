module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;
reg z;

initial begin
	state = 3'b000;
end

always @(posedge clk or negedge areset) begin
	if (areset) begin
		state <= 3'b000;
		z <= 1'b0;
	end else begin
		state <= next_state;
		z <= (state == 3'b111) ? ~x : x;
	end
end

always @(*) begin
	case (state)
		3'b000: next_state = 3'b001;
		3'b001: next_state = 3'b010;
		3'b010: next_state = 3'b011;
		3'b011: next_state = 3'b100;
		3'b100: next_state = 3'b101;
		3'b101: next_state = 3'b110;
		3'b110: next_state = 3'b111;
		3'b111: next_state = 3'b000;
	endcase
end

endmodule
