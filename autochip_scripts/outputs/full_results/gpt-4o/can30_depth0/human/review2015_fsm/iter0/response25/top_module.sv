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
    // State encoding
    typedef enum logic [2:0] {
        IDLE,    // 0
        DETECT1, // 1
        DETECT11,// 2
        DETECT110,// 3
        DETECT1101,// 4
        SHIFT,   // 5
        COUNT,   // 6
        DONE     // 7
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic & Output Logic
    always_ff @(posedge clk) begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state <= DETECT1;
                else
                    next_state <= IDLE;
            end
            DETECT1: begin
                if (data == 1'b1)
                    next_state <= DETECT11;
                else
                    next_state <= IDLE;
            end
            DETECT11: begin
                if (data == 1'b0)
                    next_state <= DETECT110;
                else
                    next_state <= IDLE;
            end
            DETECT110: begin
                if (data == 1'b1)
                    next_state <= DETECT1101;
                else
                    next_state <= IDLE;
            end
            DETECT1101: begin
                shift_ena <= 1;
                shift_counter <= 4 - 1;
                next_state <= SHIFT;
            end
            SHIFT: begin
                shift_ena <= 1;
                if (shift_counter == 0)
                    next_state <= COUNT;
                else
                    shift_counter <= shift_counter - 1;
            end
            COUNT: begin
                counting <= 1;
                if (done_counting)
                    next_state <= DONE;
                else
                    next_state <= COUNT;
            end
            DONE: begin
                done <= 1;
                if (ack)
                    next_state <= IDLE;
                else
                    next_state <= DONE;
            end
            default: next_state <= IDLE;
        endcase
    end
endmodule
