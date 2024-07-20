module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	end else begin
		case (state)
			0: begin // A
				if (in) begin
					state <= 2'b1;
				end else begin
					state <= 2'b0;
				end
			end
			1: begin // B
				if (in) begin
					state <= 2'b1;
				end else begin
					state <= 2'b2;
				end
			end
			2: begin // C
				if (in) begin
					state <= 2'b3;
				end else begin
					state <= 2'b0;
				end
			end
			3: begin // D
				if (in) begin
					state <= 2'b1;
				end else begin
					state <= 2'b2;
				end
			end
		endcase
	end
end

always @* begin
	if (state == 2'b3) begin
		out = 1'b1;
	end else begin
		out = 1'b0;
	end
end

endmodule
