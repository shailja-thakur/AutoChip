module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire next_state;
reg z_out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		z_out <= 0;
	end
	else begin
		if (w) begin
			case (state)
				3'b000: begin
					state <= 3'b001;
					z_out <= 0;
				end
				3'b001: begin
					state <= 3'b000;
					z_out <= 0;
				end
				3'b010: begin
					state <= 3'b010;
					z_out <= 0;
				end
				3'b011: begin
					state <= 3'b011;
					z_out <= 1;
				end
				3'b100: begin
					state <= 3'b101;
					z_out <= 0;
				end
				3'b101: begin
					state <= 3'b011;
					z_out <= 1;
				end
				3'b110: begin
					state <= 3'b110;
					z_out <= 0;
				end
				3'b111: begin
					state <= 3'b000;
					z_out <= 0;
				end
			endcase
		end
		else begin
			case (state)
				3'b000: begin
					state <= 3'b010;
					z_out <= 0;
				end
				3'b001: begin
					state <= 3'b001;
					z_out <= 0;
				end
				3'b010: begin
					state <= 3'b100;
					z_out <= 0;
				end
				3'b011: begin
					state <= 3'b011;
					z_out <= 1;
				end
				3'b100: begin
					state <= 3'b110;
					z_out <= 0;
				end
				3'b101: begin
					state <= 3'b011;
					z_out <= 1;
				end
				3'b110: begin
					state <= 3'b100;
					z_out <= 1;
				end
				3'b111: begin
					state <= 3'b010;
					z_out <= 0;
				end
			endcase
		end
	end
end

assign next_state = state;

assign z = z_out;

endmodule
