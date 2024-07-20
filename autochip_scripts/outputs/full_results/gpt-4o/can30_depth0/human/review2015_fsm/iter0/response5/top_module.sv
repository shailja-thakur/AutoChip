module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE,               // Idle state, looking for 1101 pattern
        PATTERN_DETECTED,   // 1101 pattern detected, start shifting
        COUNT_WAIT,         // Waiting for counter to finish counting
        DONE,               // Notifying user timer is done
        WAIT_ACK            // Waiting for user to acknowledge
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_counter;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 4'd0;
        end else begin
            state <= next_state;

            // Shift counter management
            if (state == PATTERN_DETECTED) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 4'd0;
            end
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default values for outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = IDLE;
                end

                // Check for the 1101 pattern
                if ({data, state[3:1]} == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                end
            end
            
            PATTERN_DETECTED: begin
                shift_ena = 1'b1;
                if (shift_counter == 4'd4) begin
                    next_state = COUNT_WAIT;
                end else begin
                    next_state = PATTERN_DETECTED;
                end
            end
            
            COUNT_WAIT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT_WAIT;
                end
            end
            
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
