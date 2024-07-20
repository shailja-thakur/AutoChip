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

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_1,
        PATTERN_2,
        PATTERN_3,
        PATTERN_4,
        SHIFT_ENABLE,
        COUNTING,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = PATTERN_1;
            end
            PATTERN_1: begin
                if (data == 1'b1)
                    next_state = PATTERN_2;
                else
                    next_state = IDLE;
            end
            PATTERN_2: begin
                if (data == 1'b0)
                    next_state = PATTERN_3;
                else
                    next_state = IDLE;
            end
            PATTERN_3: begin
                if (data == 1'b1)
                    next_state = PATTERN_4;
                else
                    next_state = IDLE;
            end
            PATTERN_4: begin
                if (data == 1'b1)
                    next_state = SHIFT_ENABLE;
                else
                    next_state = IDLE;
            end
            SHIFT_ENABLE: begin
                shift_ena = 1'b1;
                next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE_STATE;
            end
            DONE_STATE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
