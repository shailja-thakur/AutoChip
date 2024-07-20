module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    integer shift_counter;

    // State transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to hold the current state
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (~data) next_state = DETECT_110;
                // else stay in DETECT_11
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data) next_state = DETECT_1101;
                else next_state = IDLE;
            end
            DETECT_1101: begin
                if (~data) next_state = IDLE;
                else next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 4) next_state = COUNT;
            end
            COUNT: begin
                counting = 1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;        // For safety, should not happen
        endcase
    end

    // Shift counter for SHIFT state
    always_ff @(posedge clk or posedge reset) begin
        if (reset || state != SHIFT) begin
            shift_counter <= 0;
        end else if (state == SHIFT && shift_ena) begin
            shift_counter <= shift_counter + 1;
        end
    end

endmodule
