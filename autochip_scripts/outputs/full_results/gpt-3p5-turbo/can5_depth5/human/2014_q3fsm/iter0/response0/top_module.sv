module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	end else begin
		state <= next_state;
	end
end

// State transition logic
always @* begin
	case (state)
		2'b00: begin
			if (s == 1'b1) begin
				next_state = 2'b01;
			end else begin
				next_state = 2'b00;
			end
		end
		2'b01: begin
			if (w == 1'b1) begin
				next_state = 2'b10;
			end else begin
				next_state = 2'b01;
			end
		end
		2'b10: begin
			if (w == 1'b1) begin
				next_state = 2'b11;
			end else begin
				next_state = 2'b10;
			end
		end
		2'b11: begin
			if (w == 1'b1) begin
				next_state = 2'b00;
				z <= 1'b1;
			end else begin
				next_state = 2'b10;
				z <= 1'b0;
			end
		end
		default: next_state = 2'b00;
	endcase
end

endmodule
