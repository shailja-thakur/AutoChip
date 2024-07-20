module top_module (
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // state definitions
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,       // initial state
        S_CHECK = 3'b001,      // pattern check state
        S_SHIFT = 3'b010,      // shift pattern check
        S_COUNT = 3'b011,      // counting state
        S_DONE = 3'b100        // done state
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_counter;  // counter for 4 clock cycles

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            shift_counter <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;

            if (state == S_SHIFT && next_state != S_SHIFT)
                shift_counter <= 0;
            else if (state == S_SHIFT)
                shift_counter <= shift_counter + 1;

            if (state == S_IDLE)
                shift_ena <= 0;
            else if (state == S_SHIFT)
                shift_ena <= 1;
            else
                shift_ena <= 0;

            if (state == S_COUNT)
                counting <= 1;
            else
                counting <= 0;

            if (state == S_DONE)
                done <= 1;
            else
                done <= 0;
        end
    end

    always @(*) begin
        case (state)
            S_IDLE:
                if (data == 1'b1)
                    next_state = S_CHECK;
                else
                    next_state = S_IDLE;

            S_CHECK: begin
                if ({state, data} == 4'b1101)
                    next_state = S_SHIFT;
                else
                    next_state = S_IDLE;
            end

            S_SHIFT:
                if (shift_counter == 4)
                    next_state = S_COUNT;
                else
                    next_state = S_SHIFT;

            S_COUNT:
                if (done_counting)
                    next_state = S_DONE;
                else
                    next_state = S_COUNT;

            S_DONE:
                if (ack)
                    next_state = S_IDLE;
                else
                    next_state = S_DONE;

            default:
                next_state = S_IDLE;
        endcase
    end

endmodule
