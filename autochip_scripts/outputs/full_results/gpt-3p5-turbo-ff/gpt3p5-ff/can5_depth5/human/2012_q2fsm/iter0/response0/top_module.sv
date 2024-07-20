module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg temp_state;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		state <= temp_state;
	end
end

always @(state, w) begin
	case (state)
		3'b000: begin
			if (w) begin
				temp_state = 3'b001;
			end else begin
				temp_state = 3'b000;
			end
		end
		3'b001: begin
			if (w) begin
				temp_state = 3'b101;
			end else begin
				temp_state = 3'b100;
			end
		end
		3'b100: begin
			if (w) begin
				temp_state = 3'b011;
			end else begin
				temp_state = 3'b010;
			end
		end
		3'b101: begin
			if (w) begin
				temp_state = 3'b010;
			end else begin
				temp_state = 3'b100;
			end
		end
		3'b010: begin
			if (w) begin
				temp_state = 3'b110;
			end else begin
				temp_state = 3'b100;
			end
		end
		3'b011: begin
			if (w) begin
				temp_state = 3'b101;
			end else begin
				temp_state = 3'b100;
			end
		end
		3'b110: begin
			if (w) begin
				temp_state = 3'b010;
			end else begin
				temp_state = 3'b100;
			end
		end
	endcase
end

// FSM output
assign z = (state == 3'b101 || state == 3'b110);

endmodule
