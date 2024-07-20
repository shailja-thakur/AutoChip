module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        START_BIT = 3'd1,
        DATA_BITS = 3'd2,
        STOP_BIT = 3'd3,
        ERROR = 3'd4
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count; // Counter for data bits

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b0;
        end 
        else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                bit_count <= bit_count + 1;
            end 
            else if (current_state == STOP_BIT || current_state == IDLE || current_state == ERROR) begin
                bit_count <= 3'b0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to no state change
        done = 1'b0; // Default output
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS; // Move to data bits state after start bit
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) // All 8 data bits received
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit expected
                    done = 1'b1;
                    next_state = IDLE;
                end 
                else begin
                    next_state = ERROR; // Error state if stop bit is not correct
                end
            end
            ERROR: begin
                if (in == 1'b1) // Wait for line to go idle before resetting
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
