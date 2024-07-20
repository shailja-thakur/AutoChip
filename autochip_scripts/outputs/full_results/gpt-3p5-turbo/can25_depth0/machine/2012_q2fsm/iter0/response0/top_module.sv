module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000;
		z <= 0;
	end else begin
		case (state)
			3'b000: begin
				if (w) state <= 3'b001;
				else state <= 3'b000;
			end
			3'b001: begin
				if (w) state <= 3'b010;
				else state <= 3'b011;
			end
			3'b010: begin
				if (w) state <= 3'b100;
				else state <= 3'b011;
			end
			3'b011: begin
				if (w) state <= 3'b000;
				else state <= 3'b101;
			end
			3'b100: begin
				if (w) state <= 3'b100;
				else state <= 3'b100;
			end
			3'b101: begin
				if (w) state <= 3'b011;
				else state <= 3'b110;
			end
			default: state <= 3'b000;
		endcase
	end
end

always @(state) begin
	if (state == 3'b101 || state == 3'b110) z <= 1;
	else z <= 0;
end

endmodule
