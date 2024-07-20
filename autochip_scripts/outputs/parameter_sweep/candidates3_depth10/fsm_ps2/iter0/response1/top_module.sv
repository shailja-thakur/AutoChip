module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] reg_in1, reg_in2, reg_in3;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (in[3] == 1) begin
					reg_in1 <= in;
					state <= 3'b001;
				end
			end
			3'b001: begin
				reg_in2 <= in;
				state <= 3'b010;
			end
			3'b010: begin
				reg_in3 <= in;
				state <= 3'b011;
			end
			3'b011: begin
				done <= 1;
				state <= 3'b000;
			end
		endcase
	end
end
endmodule
