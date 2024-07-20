module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] prev_byte;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		prev_byte <= 8'b0;
		done <= 1'b0;
	end else begin
		case (state)
			3'b000: begin
				if (in[3] == 1'b1) begin
					state <= 3'b001;
					prev_byte <= in;
				end
			end
			3'b001: begin
				state <= 3'b010;
				prev_byte <= in;
			end
			3'b010: begin
				if (in[3] == 1'b1) begin
					state <= 3'b011;
					prev_byte <= in;
				end else begin
					state <= 3'b000;
					prev_byte <= 8'b0;
				end
			end
			3'b011: begin
				state <= 3'b100;
				prev_byte <= in;
			end
			3'b100: begin
				state <= 3'b000;
				prev_byte <= 8'b0;
				done <= 1'b1;
			end
		endcase
	end
end

endmodule
