module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: if (x) state <= 3'b001; else state <= 3'b000;
				3'b001: if (x) state <= 3'b100; else state <= 3'b001;
				3'b010: if (x) state <= 3'b001; else state <= 3'b010;
				3'b011: if (x) state <= 3'b010; else state <= 3'b011;
				3'b100: if (x) state <= 3'b011; else state <= 3'b100;
				
				default: state <= 3'b000;
			endcase
		end
	end
	
	always @* begin
		z = (state == 3'b011 || state == 3'b100) ? 1'b1 : 1'b0;
	end
	
endmodule
