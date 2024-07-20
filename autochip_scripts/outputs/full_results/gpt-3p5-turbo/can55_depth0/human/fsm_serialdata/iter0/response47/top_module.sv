module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

reg [2:0] state;
reg [7:0] data;

always @(posedge clk) begin
	if(reset)
		state <= 3'b000;
	else
		case(state)
			3'b000: begin
				out_byte <= 8'b0;
				if(in == 1'b0)
					state <= 3'b001;
			end
			3'b001: begin
				state <= 3'b010;
				data <= 8'b0;
			end
			3'b010: begin
				data <= {data[6:0], in};
				if(in == 1'b1)
					state <= 3'b011;
			end
			3'b011: begin
				state <= 3'b100;
			end
			3'b100: begin
				if(in == 1'b1) begin
					state <= 3'b101;
					out_byte <= data;
				end else
					state <= 3'b000;
			end
			3'b101: begin
				if(in == 1'b1)
					state <= 3'b110;
				else
					state <= 3'b000;
			end
			3'b110: begin
				if(in == 1'b1)
					state <= 3'b111;
				else
					state <= 3'b000;
			end
			3'b111: begin
				state <= 3'b000;
				done <= 1'b1;
			end
		endcase
end

endmodule
