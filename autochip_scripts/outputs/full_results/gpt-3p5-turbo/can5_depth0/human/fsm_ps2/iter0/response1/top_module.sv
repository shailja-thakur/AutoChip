module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
wire start_message;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
	end else begin
		case(state)
			0: begin // Idle state
				if (in[3] == 1) begin
					state <= 1;
				end
			end
			1: begin // Start of message
				state <= 2;
			end
			2: begin // Second byte
				state <= 3;
			end
			3: begin // Third byte
				state <= 0;
			end
		endcase
	end
end

assign start_message = (state == 1);

assign done = (state == 3);

endmodule
