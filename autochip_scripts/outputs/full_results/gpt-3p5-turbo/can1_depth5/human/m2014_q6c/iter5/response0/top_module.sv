module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State signals
	reg [5:0] state;
	always @(posedge w or posedge y)
		if (w || y[1] == 1'b1)
			case (state)
				6'b000001: state <= (w) ? 6'b000010 : 6'b000001;
				6'b000010: state <= (w) ? 6'b000100 : 6'b000001;
				6'b000100: state <= (w) ? 6'b001000 : 6'b000001;
				6'b001000: state <= (w) ? 6'b010000 : 6'b000001;
				6'b010000: state <= (w) ? 6'b100000 : 6'b000001;
				6'b100000: state <= (w) ? 6'b000001 : 6'b000001;
			endcase

	// Next-state logic
	always @(state)
		case (state)
			6'b000001: begin
				Y2 <= 1'b0;
				Y4 <= 1'b1;
			end
			6'b000010: begin
				Y2 <= 1'b0;
				Y4 <= 1'b0;
			end
			6'b000100, 6'b110000: begin
				Y2 <= 1'b0;
				Y4 <= 1'b0;
			end
			6'b001000: begin
				Y2 <= 1'b1;
				Y4 <= 1'b0;
			end
			6'b010000: begin
				Y2 <= 1'b0;
				Y4 <= 1'b0;
			end
			6'b100000: begin
				Y2 <= 1'b1;
				Y4 <= 1'b1;
			end
			default: begin
				Y2 <= 1'b0;
				Y4 <= 1'b0;
			end
		endcase

endmodule
