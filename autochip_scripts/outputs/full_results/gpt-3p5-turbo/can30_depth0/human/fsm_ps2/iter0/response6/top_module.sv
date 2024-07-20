module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		count <= 2'b00;
	end else begin
		case (state)
			2'b00:
				if (in[3]) begin
					state <= 2'b01;
					count <= 2'b00;
				end
				else begin
					state <= 2'b00;
					count <= 2'b00;
				end
			2'b01:
				if (count == 2'b10) begin
					state <= 2'b00;
					count <= 2'b00;
					done <= 1'b1;
				end
				else begin
					state <= 2'b01;
					count <= count + 1;
				end
		endcase
	end
end

endmodule
