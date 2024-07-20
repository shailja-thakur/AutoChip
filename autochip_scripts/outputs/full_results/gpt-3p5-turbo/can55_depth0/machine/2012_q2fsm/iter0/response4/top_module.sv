module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	else if (w) begin
		case(state)
			3'b000: state <= 3'b001;
			3'b001: state <= 3'b010;
			3'b010: state <= 3'b100;
			3'b011: state <= 3'b100;
			3'b100: state <= 3'b100;
			3'b101: state <= 3'b011;
		endcase
	else begin
		case(state)
			3'b000: state <= 3'b000;
			3'b001: state <= 3'b001;
			3'b010: state <= 3'b011;
			3'b011: state <= 3'b110;
			3'b100: state <= 3'b100;
			3'b101: state <= 3'b101;
		endcase
	end
end

always @(state) begin
	if (state == 3'b100 || state == 3'b101)
		z = 1;
	else
		z = 0;
end

endmodule
