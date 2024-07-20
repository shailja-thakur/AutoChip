module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00; // Initialize state to BYTE1
	else begin
		case (state)
			2'b00: begin // BYTE1 state
				if (in[2] == 1'b1)
					state <= 2'b01; // Transition to BYTE2
				else
					state <= 2'b00; // Transition to BYTE1
			end
			2'b01: begin // BYTE2 state
				state <= 2'b10; // Transition to BYTE3
			end
			2'b10: begin // BYTE3 state
				state <= 2'b11; // Transition to DONE
			end
			2'b11: begin // DONE state
				if (in[2] == 1'b0)
					state <= 2'b00; // Transition to BYTE1
				else
					state <= 2'b11; // Remain in DONE
			end
			default: state <= 2'b00;
		endcase
	end
end

always @(posedge clk) begin
	if (reset)
		out_reg <= 0; // Initialize out_reg to 0
	else begin
		if (done)
			out_reg <= {in[7:0], out_reg[23:8]}; // Shift in input on each clock cycle
	end
end

assign out_bytes = out_reg;
assign done = (state == 2'b11);

endmodule
