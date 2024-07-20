module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always@(posedge clk) begin
	if (reset == 1) begin
		state <= 2'b00;
	end else begin
		case (state)
			2'b00: begin
				if (in == 1) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
			2'b01: begin
				if (in == 1) begin
					state <= 2'b01;
				end else begin
					state <= 2'b10;
				end
			end
			2'b10: begin
				if (in == 1) begin
					state <= 2'b11;
				end else begin
					state <= 2'b00;
				end
			end
			2'b11: begin
				if (in == 1) begin
					state <= 2'b01;
				end else begin
					state <= 2'b10;
				end
			end
		endcase
	end
end

always@(state) begin
	if (state == 2'b11) begin
		out = 1;
	else begin
		out = 0;
	end
end

endmodule
