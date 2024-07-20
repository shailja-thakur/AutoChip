module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack 
);

    // Define states for FSM
    typedef enum reg [2:0] {
        IDLE,         // Waiting for the pattern
        SHIFT,        // Shifting in duration
        COUNT,        // Counting duration
        DONE,         // Done counting, waiting for ack
        WAIT_ACK      // Waiting for user acknowledgment
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] pattern_shift_reg;  // To detect 4-bit pattern

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Pattern detection
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift_reg <= 3'b000;
        end else if (current_state == IDLE) begin
            pattern_shift_reg <= {pattern_shift_reg[1:0], data};
        end
    end

    // Next state logic
    always @(*) begin
        // Default values
        next_state = current_state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (current_state)
            IDLE: begin
                // Detect pattern 1101
                if (pattern_shift_reg == 3'b101 && data == 1) begin
                    next_state = SHIFT;
                end
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (current_state_counter == 4) begin
                    next_state = COUNT;
                end
            end
            
            COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end

        endcase
    end

endmodule
