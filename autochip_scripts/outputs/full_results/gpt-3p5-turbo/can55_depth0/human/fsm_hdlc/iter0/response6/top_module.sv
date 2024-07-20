module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

reg [2:0] state, next_state;

parameter IDLE = 3'b000;
parameter CHECK_DISC = 3'b001;
parameter CHECK_FLAG = 3'b010;
parameter CHECK_ERR = 3'b011;
parameter FLAG = 3'b100;
parameter ERR = 3'b101;

assign disc = (state == FLAG);
assign flag = (state == FLAG);
assign err = (state == ERR);

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		IDLE:
			if (in) begin
				next_state = CHECK_DISC;
			end else begin
				next_state = IDLE;
			end
		CHECK_DISC:
			if (in) begin
				next_state = CHECK_FLAG;
			end else begin
				next_state = IDLE;
			end
		CHECK_FLAG:
			if (in) begin
				next_state = CHECK_ERR;
			end else begin
				next_state = FLAG;
			end
		CHECK_ERR:
			if (in) begin
				next_state = ERR;
			end else begin
				next_state = FLAG;
			end
		FLAG:
			if (in) begin
				next_state = FLAG;
			end else begin
				next_state = IDLE;
			end
		ERR:
			if (in) begin
				next_state = ERR;
			end else begin
				next_state = IDLE;
			end
	endcase
end

endmodule
