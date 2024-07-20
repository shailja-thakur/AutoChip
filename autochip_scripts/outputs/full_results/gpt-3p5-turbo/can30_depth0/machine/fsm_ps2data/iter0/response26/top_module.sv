module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] register;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else
	begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			BYTE2: begin
				if (in[2] == 1)
					state <= BYTE3;
				else
					state <= BYTE2;
			end
			BYTE3: begin
				if (in[2] == 1)
					state <= DONE;
				else
					state <= BYTE3;
			end
			DONE: begin
				if (in[2] == 0)
					state <= BYTE1;
				else
					state <= DONE;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == DONE)
		register <= in;
	else
		register <= {register[15:0], in};
end

assign out_bytes = register;
assign done = (state == DONE);

endmodule
