module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
	
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin
				if (w) begin
					state <= 3'b000;
				end else begin
					state <= 3'b001;
				end
			end
			3'b001: begin
				if (w) begin
					state <= 3'b001;
				end else begin
					state <= 3'b010;
				end
			end
			3'b010: begin
				if (w) begin
					state <= 3'b101;
				end else begin
					state <= 3'b011;
				end
			end
			3'b011: begin
				if (w) begin
					state <= 3'b101;
				end else begin
					state <= 3'b100;
				end
			end
			3'b100: begin
				if (w) begin
					state <= 3'b110;
				end else begin
					state <= 3'b101;
				end
			end
			3'b101: begin
				if (w) begin
					state <= 3'b110;
				end else begin
					state <= 3'b001;
				end
			end
			3'b110: begin
				if (w) begin
					state <= 3'b011;
				end else begin
					state <= 3'b100;
				end
			end
			default: state <= 3'b000;
		endcase
	end
end

assign z = (state == 3'b000 || state == 3'b010 || state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
