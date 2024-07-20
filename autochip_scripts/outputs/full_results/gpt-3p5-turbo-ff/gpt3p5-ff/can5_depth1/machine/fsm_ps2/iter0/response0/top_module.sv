module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;

always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= BYTE1;
	else
	begin
		case(state)
			BYTE1: if (in[2] == 1)
						state <= BYTE2;
					else
						state <= BYTE1;
			BYTE2: state <= BYTE3;
			BYTE3: state <= DONE;
			DONE: if (in[2] == 1)
						state <= BYTE2;
					else
						state <= BYTE1;
		endcase
	end
end

assign done = (state == DONE);

endmodule
