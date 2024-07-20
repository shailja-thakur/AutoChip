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

    // State Encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,
        S_DETECT1 = 3'b001,
        S_DETECT11 = 3'b010,
        S_DETECT110 = 3'b011,
        S_DETECT1101 = 3'b100,
        S_SHIFT = 3'b101,
        S_COUNT = 3'b110,
        S_DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_cycle_counter;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = state; // default state to hold
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            S_IDLE: begin
                if (data)
                    next_state = S_DETECT1;
            end
            S_DETECT1: begin
                if (data)
                    next_state = S_DETECT11;
                else
                    next_state = S_IDLE;
            end
            S_DETECT11: begin
                if (~data)
                    next_state = S_DETECT110;
                else
                    next_state = S_IDLE;
            end
            S_DETECT110: begin
                if (data)
                    next_state = S_DETECT1101;
                else
                    next_state = S_IDLE;
            end
            S_DETECT1101: begin
                if (data)
                    next_state = S_IDLE;
                else
                    next_state = S_SHIFT;
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_cycle_counter == 2'b11)
                    next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end

    // Shift Cycle Counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_cycle_counter <= 2'b00;
        else if (state == S_SHIFT)
            shift_cycle_counter <= shift_cycle_counter + 1;
        else
            shift_cycle_counter <= 2'b00;
    end

endmodule
