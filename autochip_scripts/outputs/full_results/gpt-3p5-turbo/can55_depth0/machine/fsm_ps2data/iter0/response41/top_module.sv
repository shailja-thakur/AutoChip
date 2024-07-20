module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
	reg [23:0] out_reg;
	reg [1:0] state;
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
			out_reg <= 24'b0;
		end else begin
			case (state)
				2'b00: begin // BYTE1 state
					if (in[2] == 1'b1) begin
						state <= 2'b01; // Transition to BYTE2 state
					end else begin
						state <= 2'b00; // Stay in BYTE1 state
					end
				end
				2'b01: begin // BYTE2 state
					state <= 2'b10; // Transition to BYTE3 state
				end
				2'b10: begin // BYTE3 state
					state <= 2'b11; // Transition to DONE state
				end
				2'b11: begin // DONE state
					if (in[2] == 1'b0) begin
						state <= 2'b00; // Transition to BYTE1 state
					end else begin
						state <= 2'b11; // Stay in DONE state
					end
				end
				default: state <= 2'b00;
			endcase
			if (state != 2'b10) begin
				out_reg <= {in, out_reg[23:8]}; // Shift in input data
			end
		end
	end

	assign out_bytes = out_reg;
	assign done = (state == 2'b11);
endmodule
