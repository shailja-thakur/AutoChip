module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
			2'b01: begin // BYTE2
				state <= 2'b10;
			end
			2'b10: begin // BYTE3
				state <= 2'b11;
			end
			2'b11: begin // DONE
				if (in[2] == 1'b1)
					state <= 2'b01;
				else
					state <= 2'b00;
				done <= 1;
			end
			default: state <= 2'b00;
		endcase
	end
end

endmodule
