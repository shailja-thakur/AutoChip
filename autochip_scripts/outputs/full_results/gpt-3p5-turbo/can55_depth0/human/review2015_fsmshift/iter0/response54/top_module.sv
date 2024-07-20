module top_module(
	input clk,
	input reset,
	output shift_ena);

reg [2:0] state;
reg [3:0] count;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= S0;
		count <= 0;
		shift_ena <= 1;
	end else begin
		case (state)
			S0: begin
				if (count == 3'b100)
					state <= S1;
				else
					count <= count + 1;
			end
			S1: begin
				if (count == 3'b100)
					state <= S2;
				else
					count <= count + 1;
			end
			S2: begin
				count <= count;
			end
		endcase
	end
end

assign shift_ena = (state == S0) || (state == S1);

endmodule
