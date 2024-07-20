module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	//state declaration
	reg [1:0] state;
	
	//output declaration
	wire z;
	
	//combinational logic
	assign z = ~x + 1;
	
	//state machine
	always @(posedge clk or negedge areset)
	begin
		if (areset == 0)
			state <= 2'b00;
		else
		begin
			case(state)
				2'b00: // Initial State
					if (areset) 
						state <= 2'b00;
					else
						state <= 2'b01;
						
				2'b01: // Conversion State
					if (x) 
						state <= 2'b01;
					else
						state <= 2'b10;
					
				2'b10: // Reset State
					state <= 2'b00;
					
				default:
					state <= 2'b00;
			endcase
		end
	end
	
	//output assignment
	assign z = (state == 2'b00) ? 0 : z;
endmodule
