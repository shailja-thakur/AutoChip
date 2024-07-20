module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if(reset)
		state <= 2'b00; // initial state A
	else begin
		case(state)
			2'b00: begin // state A
				if(in)
					state <= 2'b01; // change state to B
				else
					state <= 2'b00;
			end
			2'b01: begin // state B
				if(in)
					state <= 2'b01; // change state to B
				else
					state <= 2'b10; // change state to C
			end
			2'b10: begin // state C
				if(in)
					state <= 2'b11; // change state to D
				else
					state <= 2'b00; // change state to A
			end
			2'b11: begin // state D
				if(in)
					state <= 2'b01; // change state to B
				else
					state <= 2'b10; // change state to C
			end
		endcase
	end
end

always @(state) begin
	if(state == 2'b11) // state D
		out = 1; // set out to 1
	else
		out = 0; // set out to 0
end

endmodule
