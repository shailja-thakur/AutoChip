module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    
	// Define the states of the FSM
    typedef enum logic [1:0] {
    	STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E
    } state_t;
    
    // Declare the state and next state variables
    state_t state, next_state;
    
    // Declare the internal counter variable to count x transitions
    reg [1:0] x_counter;
    
    // Declare the internal counter variable to count y transitions
    reg [1:0] y_counter;
    
    always @(posedge clk or negedge resetn) begin
    	if (!resetn) begin
    		state <= STATE_A;    // Initialize to state A on reset
            f <= 0;              // Initialize f to 0 on reset
            g <= 0;              // Initialize g to 0 on reset
            x_counter <= 0;      // Reset x_counter to 0 on reset
            y_counter <= 0;      // Reset y_counter to 0 on reset
        end else begin
            state <= next_state; // Update state on clock edge
            f <= 0;              // Set f to 0 by default
            
            case (state)
            	STATE_A: begin
            		if (clk) begin
            			next_state <= STATE_B; // Transition to state B after the next clock edge
            		end else begin
            			next_state <= STATE_A; // Stay in state A
            		end
                end
                
                STATE_B: begin
                	if (clk) begin
            			next_state <= STATE_C; // Transition to state C after the next clock edge
            		end else begin
            			next_state <= STATE_B; // Stay in state B
            		end
                end
                
                STATE_C: begin
                	if (clk) begin
            			next_state <= STATE_D; // Transition to state D after the next clock edge
            		end else begin
            			next_state <= STATE_C; // Stay in state C
            		end
                end
                
                STATE_D: begin
                	if (clk) begin
            			next_state <= STATE_E; // Transition to state E after the next clock edge
            		end else begin
            			next_state <= STATE_D; // Stay in state D
            		end
                end
                
                STATE_E: begin
                	next_state <= STATE_E; // Stay in state E
                	
                	if (x_counter == 3) begin
                		f <= 1;         // Set f to 1 for one clock cycle after the next clock edge
                    end else begin
                    	f <= 0;         // Keep f as 0
                    end
                    
                    if (y_counter == 2) begin
                    	g <= 1;         // Set g to 1 permanently
                    end else if (y == 1) begin
                    	y_counter <= y_counter + 1; // Increment y_counter if y is 1 within two clock cycles
                    end else begin
                    	g <= 0;         // Set g to 0 permanently
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk or negedge resetn) begin
    	if (!resetn) begin
    		x_counter <= 0;      // Reset x_counter to 0 on reset
    	end else begin
    		if (state == STATE_E && clk) begin
    			x_counter <= x_counter + 1; // Increment x_counter if we are in state E and on a clock edge
        	end else if (state != STATE_E) begin
        		x_counter <= 0;      // Reset x_counter if we are not in state E
        	end
    	end
    end
    
    always @(posedge clk or negedge resetn) begin
    	if (!resetn) begin
    		y_counter <= 0;      // Reset y_counter to 0 on reset
    	end else begin
    		if (state == STATE_E && clk) begin
    			y_counter <= 0;      // Reset y_counter if we are in state E and on a clock edge
        	end else if (state == STATE_E && y == 0) begin
        		y_counter <= y_counter + 1; // Increment y_counter if we are in state E, y is 0
        	end
    	end
    end
    
endmodule
