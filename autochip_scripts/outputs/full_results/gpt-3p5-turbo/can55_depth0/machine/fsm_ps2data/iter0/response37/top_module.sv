module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [23:0] register;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else begin
		case (state)
			BYTE1: begin
				if (in[2])
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			BYTE2: begin
				if (in[2])
					state <= BYTE3;
				else
					state <= BYTE1;
			end
			BYTE3: begin
				if (in[2])
					state <= DONE;
				else
					state <= BYTE1;
			end
			DONE: begin
				if (in[2])
					state <= DONE;
				else
					state <= BYTE1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == DONE)
		done <= 1;
	else
		done <= 0;
	
	if (state == DONE)
		out_bytes <= register[23:0];
	else
		out_bytes <= {register[15:0], in};
	
	register <= {register[7:0], in};
end

endmodule
