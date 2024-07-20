module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // B state
		else begin
			case (state)
				2'b00: begin // A state
					if (in)
						state <= 2'b01; // A state
					else
						state <= 2'b10; // B state
				end
				2'b01: begin // B state
					if (in)
						state <= 2'b01; // B state
					else
						state <= 2'b10; // A state
				end
				default: state <= 2'b10; // B state
			endcase
		end
	end
	
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
	
endmodule
