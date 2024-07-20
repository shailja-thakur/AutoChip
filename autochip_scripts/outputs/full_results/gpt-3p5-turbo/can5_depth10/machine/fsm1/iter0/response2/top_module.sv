module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
	if (areset) begin
		state <= 2'b1;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		2'b00: begin // state A
			if (in) begin
				next_state = 2'b00;
			end else begin
				next_state = 2'b01;
			end
		end
		
		2'b01: begin // state B
			if (in) begin
				next_state = 2'b01;
			end else begin
				next_state = 2'b00;
			end
		end
	endcase
end

always @(state) begin
	if (state == 2'b01) begin
		out = 1'b1;
	else
		out = 1'b0;
	end
end

endmodule
