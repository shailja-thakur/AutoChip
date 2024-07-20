module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire out;

always @(posedge clk) begin
	if(reset) begin
		state <= 2'b10; // reset state B
	end else begin
		case(state)
			2'b00: begin // state A
				if(in) begin
					state <= 2'b01; // transition to A
				else
					state <= 2'b10; // transition to B
			end
			2'b01: begin // state B
				if(in) begin
					state <= 2'b01; // transition to B
				else
					state <= 2'b00; // transition to A
			end
		endcase
	end
end

assign out = (state == 2'b00) ? 1'b0 : 1'b1;

endmodule
