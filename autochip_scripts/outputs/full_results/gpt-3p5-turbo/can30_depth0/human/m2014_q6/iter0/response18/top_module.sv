module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b0;
		else begin
			case (state)
				3'b000: // A
					if (w)
						state <= 3'b000;
					else
						state <= 3'b001;
				3'b001: // B
					if (w)
						state <= 3'b011;
					else
						state <= 3'b000;
				3'b010: // C
					if (w)
						state <= 3'b101;
					else
						state <= 3'b011;
				3'b011: // D
					if (w)
						state <= 3'b000;
					else
						state <= 3'b010;
				3'b100: // E
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b011;
				3'b101: // F
                    if (w)
                        state <= 3'b010;
                    else
                        state <= 3'b011;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			3'b000: // A
				z = 1'b0;
			3'b001: // B
				z = 1'b0;
			3'b010: // C
				z = 1'b0;
			3'b011: // D
				z = 1'b0;
			3'b100: // E
				z = 1'b1;
			3'b101: // F
				z = 1'b1;
		endcase
	end
endmodule
