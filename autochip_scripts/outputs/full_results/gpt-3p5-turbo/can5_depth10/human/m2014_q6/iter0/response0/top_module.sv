module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		z <= 0;
	end else begin
		case (state)
			3'b000: begin
				if (w) begin
					state <= 3'b000;
					z <= 0;
				end else begin
					state <= 3'b001;
					z <= 0;
				end
			end
			
			3'b001: begin
				if (w) begin
					state <= 3'b010;
					z <= 0;
				end else begin
					state <= 3'b001;
					z <= 0;
				end
			end
			
			3'b010: begin
				if (w) begin
					state <= 3'b100;
					z <= 0;
				end else begin
					state <= 3'b011;
					z <= 0;
				end
			end
			
			3'b011: begin
				if (w) begin
					state <= 3'b000;
					z <= 0;
				end else begin
					state <= 3'b011;
					z <= 0;
				end
			end
			
			3'b100: begin
				if (w) begin
					state <= 3'b100;
					z <= 1;
				end else begin
					state <= 3'b101;
					z <= 0;
				end
			end
			
			3'b101: begin
				if (w) begin
					state <= 3'b110;
					z <= 0;
				end else begin
					state <= 3'b101;
					z <= 0;
				end
			end
			
			3'b110: begin
				if (w) begin
					state <= 3'b010;
					z <= 0;
				end else begin
					state <= 3'b101;
					z <= 0;
				end
			end
		endcase
	end
end

endmodule
