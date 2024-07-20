module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 2'b10; // set initial state to B
		out <= 1'b1; // set initial output to 1
	end else begin
		case(state)
			2'b10: begin // state B
				if(in) begin
					state <= 2'b10; // transition to B
				end else begin
					state <= 2'b01; // transition to A
				end
			end
			2'b01: begin // state A
				if(in) begin
					state <= 2'b01; // transition to A
				end else begin
					state <= 2'b10; // transition to B
				end
			end
			default: begin
				state <= 2'b10; // set default to B
			end
		endcase
	end
end

assign out = (state == 2'b01) ? 1'b0 : 1'b1; // set output based on state

endmodule
