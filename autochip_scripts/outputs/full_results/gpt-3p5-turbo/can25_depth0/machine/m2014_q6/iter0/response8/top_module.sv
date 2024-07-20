module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;

always @(posedge clk) begin
	if (reset)
		state <= 3'b0;
	else
		state <= next_state;
end

always @* begin
	case(state)
		3'b000: begin
			if (w)
				next_state = 3'b000;
			else
				next_state = 3'b001;
		end
		3'b001: begin
			if (w)
				next_state = 3'b010;
			else
				next_state = 3'b011;
		end
		3'b010: begin
			if (w)
				next_state = 3'b010;
			else
				next_state = 3'b100;
		end
		3'b011: begin
			if (w)
				next_state = 3'b100;
			else
				next_state = 3'b101;
		end
		3'b100: begin
			if (w)
				next_state = 3'b000;
			else
				next_state = 3'b110;
		end
		3'b101: begin
			if (w)
				next_state = 3'b110;
			else
				next_state = 3'b101;
		end
		3'b110: begin
			if (w)
				next_state = 3'b100;
			else
				next_state = 3'b011;
		end
	endcase
end

assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0;

endmodule
