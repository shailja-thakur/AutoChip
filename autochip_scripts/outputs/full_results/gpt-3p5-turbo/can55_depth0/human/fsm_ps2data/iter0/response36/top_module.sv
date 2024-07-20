module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (in[3]) begin
					byte1 <= in;
					state <= 3'b001;
				end
			end
			3'b001: begin
				byte2 <= in;
				state <= 3'b010;
			end
			3'b010: begin
				byte3 <= in;
				state <= 3'b011;
				done <= 1;
			end
			3'b011: begin
				byte1 <= 8'b0;
				byte2 <= 8'b0;
				byte3 <= 8'b0;
				state <= 3'b000;
				done <= 0;
			end
		endcase
	end
end

assign out_bytes = {byte1, byte2, byte3};

endmodule
