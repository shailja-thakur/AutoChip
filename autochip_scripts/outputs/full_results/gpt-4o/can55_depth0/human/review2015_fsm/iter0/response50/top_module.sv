module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum logic [2:0] { S_IDLE, S_DETECT_1, S_DETECT_11, S_DETECT_110, S_DETECT_1101, S_SHIFT, S_COUNT, S_DONE } state_t;
    state_t state, next_state;
    reg [1:0] shift_counter;

    // State transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            shift_counter <= 2'b00;
        end
        else begin
            state <= next_state;

            if (state == S_SHIFT)
                shift_counter <= shift_counter + 2'b01;
            else
                shift_counter <= 2'b00;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            S_IDLE: begin
                if (data == 1) next_state = S_DETECT_1;
            end
            S_DETECT_1: begin
                if (data == 1) next_state = S_DETECT_11;
                else next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data == 0) next_state = S_DETECT_110;
                else next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (data == 1) next_state = S_DETECT_1101;
                else next_state = S_IDLE;
            end
            S_DETECT_1101: begin
                if (data == 0) next_state = S_SHIFT;
            end
            S_SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 2'b11)
                    next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1;
                if (ack) next_state = S_IDLE;
            end
        endcase
    end

endmodule
