module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State Definitions
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNT,
        DONE_WAIT_ACK
    } state_t;

    state_t current_state, next_state;

    // Pattern detection shift register
    reg [3:0] pattern_shift;

    // Shift counter
    reg [2:0] shift_counter;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset
            current_state <= IDLE;
            pattern_shift <= 4'b0000;
            shift_counter <= 3'd0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            // State transition
            current_state <= next_state;
            if (current_state == PATTERN_DETECT) begin
                pattern_shift <= {pattern_shift[2:0], data};
            end
            else if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1'b1;
            end
            else begin
                // For states other than SHIFT, reset shift counter
                shift_counter <= 3'd0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end
                else begin
                    next_state = PATTERN_DETECT;
                end
            end
            
            PATTERN_DETECT: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 4) begin
                    next_state = COUNT;
                end
            end

            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE_WAIT_ACK;
                end
            end

            DONE_WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
