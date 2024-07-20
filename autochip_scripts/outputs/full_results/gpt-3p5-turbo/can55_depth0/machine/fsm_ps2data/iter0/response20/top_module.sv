module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
	begin
		out_reg <= 24'b0;
		state <= 3'b000;
	end
	else 
	begin
		case(state)
			3'b000: // BYTE1 state
				if (in[2] == 1'b1)
					state <= 3'b001; // BYTE2 state
				else
					state <= 3'b000; // Stay in BYTE1 state
			3'b001: // BYTE2 state
				if (in[2] == 1'b1)
					state <= 3'b010; // BYTE3 state
				else
					state <= 3'b000; // BYTE1 state
			3'b010: // BYTE3 state
				state <= 3'b011; // DONE state
			3'b011: // DONE state
				state <= 3'b000; // BYTE1 state
		endcase
		
		if (state == 3'b011)
			done <= 1'b1;
		else
			done <= 1'b0;
	end
end

always @(posedge clk) begin
	if (reset)
		out_reg <= 24'b0;
	else if (state == 3'b011)
		out_reg <= {out_reg[15:0], in};
end

assign out_bytes = out_reg;

endmodule
