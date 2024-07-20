module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk) begin
	if (reset == 1'b1)
		state <= 3'b000;  // state A
	else begin
		case (state)
			3'b000: begin  // state A
				if (w == 1'b0)
					state <= 3'b001;  // state B
				else
					state <= 3'b000;  // state A
			end
			
			3'b001: begin  // state B
				if (w == 1'b1)
					state <= 3'b011;  // state D
				else
					state <= 3'b010;  // state C
			end
			
			3'b010: begin  // state C
				if (w == 1'b1)
					state <= 3'b011;  // state D
				else
					state <= 3'b100;  // state E
			end
			
			3'b011: begin  // state D
				if (w == 1'b1)
					state <= 3'b000;  // state A
				else
					state <= 3'b101;  // state F
			end
			
			3'b100: begin  // state E
				if (w == 1'b1)
					state <= 3'b011;  // state D
				else
					state <= 3'b100;  // state E
			end
			
			3'b101: begin  // state F
				if (w == 1'b1)
					state <= 3'b011;  // state D
				else
					state <= 3'b010;  // state C
			end
		endcase
	end
end

always @(state) begin
	if (state == 3'b100 || state == 3'b101)
		z = 1'b1;
	else
		z = 1'b0;
end

endmodule
