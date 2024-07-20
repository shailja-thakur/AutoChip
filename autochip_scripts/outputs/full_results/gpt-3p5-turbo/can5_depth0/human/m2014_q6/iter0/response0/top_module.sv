module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire in_A, in_B, in_C, in_D, in_E, in_F;

assign in_A = (state == 3'b000);
assign in_B = (state == 3'b001);
assign in_C = (state == 3'b010);
assign in_D = (state == 3'b011);
assign in_E = (state == 3'b100);
assign in_F = (state == 3'b101);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end
	else begin
		case(state)
			3'b000: begin
				if (w == 1'b0)
					state <= 3'b010;
				else
					state <= 3'b000;
				end
			3'b001: begin
				if (w == 1'b0)
					state <= 3'b011;
				else
					state <= 3'b000;
				end
			3'b010: begin
				if (w == 1'b0)
					state <= 3'b100;
				else
					state <= 3'b011;
				end
			3'b011: begin
				if (w == 1'b0)
					state <= 3'b101;
				else
					state <= 3'b000;
				end
			3'b100: begin
				if (w == 1'b0)
					state <= 3'b100;
				else
					state <= 3'b011;
				end
			3'b101: begin
				if (w == 1'b0)
					state <= 3'b010;
				else
					state <= 3'b011;
				end
		endcase
	end
end

assign z = (state == 3'b101);

endmodule
