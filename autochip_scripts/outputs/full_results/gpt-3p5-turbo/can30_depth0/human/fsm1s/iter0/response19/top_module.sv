module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always@(posedge clk or posedge reset) begin
		if(reset) begin
			state <= 2'b10; // B state
		end else begin
			case(state)
				2'b00: begin // A state
					if(in)
						state <= 2'b00; // Stay in A state
					else
						state <= 2'b01; // Transition to B state
				end
				2'b01: begin // B state
					if(in)
						state <= 2'b01; // Stay in B state
					else
						state <= 2'b10; // Transition to A state
				end
			endcase
		end
	end
	
	assign out = (state == 2'b00) ? 1'b0 : 1'b1;
endmodule
