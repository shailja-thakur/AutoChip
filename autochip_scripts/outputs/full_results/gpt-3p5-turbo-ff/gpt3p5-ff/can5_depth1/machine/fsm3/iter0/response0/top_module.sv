module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00;
	end
	else begin
		state <= next_state;
	end
end

always @(*) begin
	case(state)
		2'b00: begin
			if (in) begin
				next_state = 2'b01;
			end
			else begin
				next_state = 2'b00;
			end
		end
		2'b01: begin
			if (in) begin
				next_state = 2'b01;
			end
			else begin
				next_state = 2'b10;
			end
		end
		2'b10: begin
			if (in) begin
				next_state = 2'b11;
			end
			else begin
				next_state = 2'b00;
			end
		end
		2'b11: begin
			if (in) begin
				next_state = 2'b01;
			end
			else begin
				next_state = 2'b10;
			end
		end
	endcase
end

endmodule
