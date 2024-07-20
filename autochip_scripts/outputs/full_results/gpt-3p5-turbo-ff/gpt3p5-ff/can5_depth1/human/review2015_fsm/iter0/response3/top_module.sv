module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    reg [3:0] state;
    reg [3:0] nextState;
    
    parameter START = 4'd0;
    parameter SHIFT = 4'd1;
    parameter WAIT = 4'd2;
    parameter DONE = 4'd3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= START;
        end else begin
            state <= nextState;
        end
	end
	
	always @(state or data) begin
	    nextState = state;
	    
	    case (state)
	        START: begin
	            if (data == 4'b1101) begin
	                nextState = SHIFT;
	            end
	        end
	        SHIFT: begin
	            nextState = WAIT;
	            shift_ena = 1;
	        end
	        WAIT: begin
	            if (done_counting) begin
	                nextState = DONE;
	                counting = 1;
	            end
	        end
	        DONE: begin
	            done = 1;
	            if (ack) begin
	                nextState = START;
	                done = 0;
	                counting = 0;
	                shift_ena = 0;
	            end
	        end
	    endcase
	end
endmodule
