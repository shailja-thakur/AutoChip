module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'10;
	reg [1:0] state, next_state;

	always @(posedge clk or negedge aresetn) begin
	    if (!aresetn)
	        state <= S0;
	    else
	        state <= next_state;
	end

	always @* begin
	    next_state = state;
	    case (state)
	        S0: if (x == 1'b1)
	                next_state = S1;
	            else
	                next_state = S0;
	        S1: if (x == 1'b0)
	                next_state = S0;
	            else if (x == 1'b1)
	                next_state = S2;
	        S2: if (x == 1'b1)
	                next_state = S2;
	            else if (x == 1'b0)
	                next_state = S0;
	    endcase
	end

	always @(posedge clk or negedge aresetn) begin
	    if (!aresetn)
	        z <= 1'b0;
	    else begin
	        if (state == S2 && x == 1'b1)
	            z <= 1'b1;
	        else
	            z <= 1'b0;
	    end
	end
endmodule
