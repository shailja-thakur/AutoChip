module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);
    // State declaration
    typedef enum logic [2:0] {
        STATE_A, // Initial state
        STATE_SET_F, // State to set f to 1
        STATE_MONITOR_X1, // Wait for x = 1
        STATE_MONITOR_X0, // Wait for x = 0
        STATE_MONITOR_X1_2, // Wait for x = 1 again (third clock cycle)
        STATE_MONITOR_Y, // Monitor y for two cycles
        STATE_G_HIGH, // g = 1 here
        STATE_G_LOW // g = 0 here
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] y_counter; // Counter to monitor y input for 2 clock cycles

    // Synchronous process for state transitions
    always @(posedge clk) begin
        if (~resetn) begin // Active low reset
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 2'b0; 
        end
        else begin
            current_state <= next_state;
        end
    end

    // Combinational process to determine next state and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        f = 0;
        
        case (current_state)
            STATE_A: begin
                if (~resetn) begin
                    next_state = STATE_A;
                end
                else begin
                    next_state = STATE_SET_F;
                end
            end
            
            STATE_SET_F: begin
                f = 1; // Set f to 1 for one cycle
                next_state = STATE_MONITOR_X1;
            end
            
            STATE_MONITOR_X1: begin
                if (x == 1) next_state = STATE_MONITOR_X0;
            end
            
            STATE_MONITOR_X0: begin
                if (x == 0) next_state = STATE_MONITOR_X1_2;
            end
            
            STATE_MONITOR_X1_2: begin
                if (x == 1) next_state = STATE_MONITOR_Y;
            end
            
            STATE_MONITOR_Y: begin
                if (y == 1) next_state = STATE_G_HIGH;
                else begin
                    if (y_counter == 2) next_state = STATE_G_LOW;
                    else y_counter = y_counter + 1;
                end
            end
            
            STATE_G_HIGH: begin
                g = 1; // g stays permanently high until resetn is low
            end
            
            STATE_G_LOW: begin
                g = 0; // g stays permanently low until resetn is low
            end
        endcase
    end
endmodule
