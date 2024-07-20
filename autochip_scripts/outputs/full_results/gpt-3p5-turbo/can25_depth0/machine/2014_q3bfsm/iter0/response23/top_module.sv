module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'd0;
		else begin
			case (state)
				3'b000:
					if (x)
						state <= 3'b001;
					else
						state <= 3'b000;
				3'b001:
					if (x)
						state <= 3'b100;
					else
						state <= 3'b001;
				3'b010:
					if (x)
						state <= 3'b001;
					else
						state <= 3'b010;
				3'b011:
					if (x)
						state <= 3'b010;
					else
						state <= 3'b011;
				3'b100:
					if (x)
						state <= 3'b011;
					else
						state <= 3'b100;
				default:
					state <= 3'd0;
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			3'b100, 3'b101, 3'b110, 3'b111:
				z <= 1'b1;
			default:
				z <= 1'b0;
		endcase
	end
endmodule
