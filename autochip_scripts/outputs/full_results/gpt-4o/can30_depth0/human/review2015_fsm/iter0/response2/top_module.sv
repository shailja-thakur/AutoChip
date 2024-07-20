module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // state declarations
    typedef enum reg [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter; // Counter for shift_ena

    // state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT1;
            end
            DETECT1: begin
                if (data == 1'b1) next_state = DETECT11;
                else next_state = IDLE;
            end
            DETECT11: begin
                if (data == 1'b0) next_state = DETECT110;
                else next_state = IDLE;
            end
            DETECT110: begin
                if (data == 1'b1) next_state = DETECT1101;
                else next_state = IDLE;
            end
            DETECT1101: begin
                if (data == 1'b1) next_state = DETECT1;
                else next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'd3)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 2'b0;
        else if (state == SHIFT && shift_ena)
            shift_counter <= shift_counter + 1'b1;
        else if (state != SHIFT)
            shift_counter <= 2'b0;
    end

endmodule
