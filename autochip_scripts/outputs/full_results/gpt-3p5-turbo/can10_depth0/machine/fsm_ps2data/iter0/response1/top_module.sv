module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [7:0] reg_in;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		reg_in <= 8'b0;
		out_bytes <= 24'b0;
		done <= 1'b0;
	end else begin
		case(state)
			2'b00: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 2'b01; // BYTE2
				else
					state <= 2'b00; // Stay in BYTE1
			end
			2'b01: begin // BYTE2
				state <= 2'b10; // BYTE3
			end
			2'b10: begin // BYTE3
				state <= 2'b11; // DONE
			end
			2'b11: begin // DONE
				if (in[2] == 1'b0)
					state <= 2'b00; // BYTE1
				else
					state <= 2'b11; // Stay in DONE
			end
		endcase

		if (state == 2'b11) begin
			out_bytes <= {reg_in, 16'b0}; // Shift in input to out_bytes
			done <= 1'b1; // Set done signal to 1
		end else begin
			reg_in <= in; // Update reg_in with input
			out_bytes <= out_bytes << 8; // Shift out_bytes left by 8 bits
			done <= 1'b0; // Set done signal to 0
		end
	end
end

endmodule
