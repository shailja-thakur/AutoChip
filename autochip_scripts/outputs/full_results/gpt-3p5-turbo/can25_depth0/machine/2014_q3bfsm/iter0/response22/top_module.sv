module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state, next_state;
	always @(posedge clk or posedge reset) begin
	    if (reset)
	        state <= 3'b000;
	    else
	        state <= next_state;
	end
	
	always @(state or x) begin
	    case (state)
	    3'b000:
	        if (x)
	            next_state = 3'b001;
	        else
	            next_state = 3'b000;
	    3'b001:
	        if (x)
	            next_state = 3'b100;
	        else
	            next_state = 3'b001;
	    3'b010:
	        if (x)
	            next_state = 3'b001;
	        else
	            next_state = 3'b010;
	    3'b011:
	        if (x)
	            next_state = 3'b010;
	        else
	            next_state = 3'b011;
	    3'b100:
	        if (x)
	            next_state = 3'b100;
	        else
	            next_state = 3'b101;
	    3'b101:
	        if (x)
	            next_state = 3'b101;
	        else
	            next_state = 3'b110;
	    3'b110:
	        if (x)
	            next_state = 3'b101;
	        else
	            next_state = 3'b111;
	    3'b111:
	        if (x)
	            next_state = 3'b111;
	        else
	            next_state = 3'b110;
	    endcase
	end
	
	always @(posedge clk) begin
	    if (state == 3'b100 || state == 3'b111)
	        z <= 1'b1;
	    else
	        z <= 1'b0;
	end
endmodule
