module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [7:0] byte_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		byte_count <= 8'd0;
	end else begin
		case (state)
			2'b00: begin // Waiting for first byte
				if (in[3]) begin
					state <= 2'b01;
					byte_count <= 8'd1;
				end
			end
			2'b01: begin // Waiting for second byte
				byte_count <= byte_count + 1;
				state <= 2'b10;
			end
			2'b10: begin // Waiting for third byte
				byte_count <= byte_count + 1;
				state <= 2'b11;
			end
			2'b11: begin // Message received
				if (byte_count == 8'd3) begin
					done <= 1'b1;
				end
				byte_count <= 8'd0;
				state <= 2'b00;
			end
		endcase
	end
end

endmodule
