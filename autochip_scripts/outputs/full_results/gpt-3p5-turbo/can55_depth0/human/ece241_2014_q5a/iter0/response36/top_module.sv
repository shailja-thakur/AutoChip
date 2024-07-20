module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;

always @ (posedge clk or negedge areset)
begin
	if (!areset)
		state <= 2'b0;
	else
	begin
		case (state)
			2'b00: begin
				if (x)
					state <= 2'b01;
				else
					state <= 2'b10;
			end
			
			2'b01: begin
				if (x)
					state <= 2'b11;
				else
					state <= 2'b10;
			end
			
			2'b10: begin
				if (x)
					state <= 2'b10;
				else
					state <= 2'b01;
			end
			
			2'b11: begin
				if (x)
					state <= 2'b10;
				else
					state <= 2'b11;
			end
		endcase
	end
end

always @ (state)
begin
	case (state)
		2'b00: z <= 1'b0;
		2'b01: z <= 1'b1;
		2'b10: z <= ~z;
		2'b11: z <= z;
	endcase
end

endmodule
