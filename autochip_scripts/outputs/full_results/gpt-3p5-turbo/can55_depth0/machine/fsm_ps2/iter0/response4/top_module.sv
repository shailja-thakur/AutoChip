module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		2'b00: begin
			next_state = (in[2]) ? 2'b01 : 2'b00;
		end

		2'b01: begin
			next_state = 2'b10;
		end

		2'b10: begin
			next_state = 2'b11;
		end

		2'b11: begin
			next_state = (in[2]) ? 2'b10 : 2'b01;
		end
	endcase
end

assign done = (state == 2'b11);

endmodule
