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
    reg [3:0] next_state;
    reg [3:0] shift_counter;
    
    reg [3:0] pattern;
    reg [3:0] data_shift;
    
    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter SHIFT = 2;
    parameter COUNT = 3;
    parameter NOTIFY = 4;
    
    always @(posedge clk) begin
    	if (reset) begin
    		state <= IDLE;
    	end else begin
    		state <= next_state;
    	end
    end
    
    always @* begin
    	next_state = state;
    	
    	case(state)
    		IDLE: begin
    			shift_ena = 0;
    			counting = 0;
    			done = 0;
    			
    			if (data == 4'b1101) begin
    				next_state = DETECT;
                    shift_counter = 0;
                    pattern = 4'b1101;
                    data_shift = 4'bxxxx;
    			end
    		end
    		
    		DETECT: begin
    			shift_ena = 0;
    			counting = 0;
    			done = 0;
    			
    			if (data != pattern) begin
    				next_state = IDLE;
    			end else if (shift_counter < 3) begin
    				shift_counter = shift_counter + 1;
    				next_state = DETECT;
    			end else begin
    				next_state = SHIFT;
    			end
    		end
    		
    		SHIFT: begin
    			shift_ena = 1;
    			counting = 0;
    			done = 0;
    			
    			if (data != pattern) begin
    				next_state = IDLE;
    			end else begin
    				next_state = COUNT;
    			end
    		end
    		
    		COUNT: begin
    			shift_ena = 0;
    			counting = 1;
    			done = 0;
    			
    			if (done_counting) begin
    				next_state = NOTIFY;
    			end
    		end
    		
    		NOTIFY: begin
    			shift_ena = 0;
    			counting = 0;
    			done = 1;
    			
    			if (ack) begin
    				next_state = IDLE;
    			end
    		end
    	endcase
    end
    
    always @(posedge clk) begin
    	if (shift_ena) begin
    		data_shift[3:0] = {data_shift[2:0], data};
    	end
    end
endmodule
