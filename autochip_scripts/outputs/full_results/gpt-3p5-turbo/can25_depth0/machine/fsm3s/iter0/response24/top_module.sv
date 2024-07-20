module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 2'b00; // initial state A
		out <= 1'b0; // out is 0
	end
	else begin
		case(state)
			2'b00: begin // state A
				if(in) state <= 2'b01; // in=1 -> state B
				// if in=0, state remains A
			end
			2'b01: begin // state B
				if(in) state <= 2'b01; // in=1 -> state B
				else state <= 2'b10; // in=0 -> state C
			end
			2'b10: begin // state C
				if(in) state <= 2'b11; // in=1 -> state D
				else state <= 2'b00; // in=0 -> state A
			end
			2'b11: begin // state D
				if(in) state <= 2'b01; // in=1 -> state B
				else state <= 2'b10; // in=0 -> state C
			end
		endcase
		out <= (state == 2'b11); // out=1 when state is D
	end
end

endmodule
