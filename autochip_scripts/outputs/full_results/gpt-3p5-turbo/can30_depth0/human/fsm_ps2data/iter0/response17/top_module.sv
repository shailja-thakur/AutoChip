module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;

assign done = (state == 3'b100);

always@(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 3'b000;
		byte_1 <= 8'b0;
		byte_2 <= 8'b0;
		byte_3 <= 8'b0;
	end else begin
		case(state)
			3'b000: begin // Discard bytes until in[3] = 1
				if(in[3] == 1'b1) begin
					byte_1 <= in;
					state <= 3'b001;
				end
			end
			3'b001: begin // Received byte 1, wait for byte 2
				byte_2 <= in;
				state <= 3'b010;
			end
			3'b010: begin // Received byte 1 and byte 2, wait for byte 3
				byte_3 <= in;
				state <= 3'b100;
			end
			3'b100: begin // Received full message, output and reset
				out_bytes <= {byte_1, byte_2, byte_3};
				byte_1 <= 8'b0;
				byte_2 <= 8'b0;
				byte_3 <= 8'b0;
				state <= 3'b000;
			end
		endcase
	end
end

endmodule
