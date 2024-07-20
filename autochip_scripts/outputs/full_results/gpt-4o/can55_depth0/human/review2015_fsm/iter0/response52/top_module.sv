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
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        MATCH_1 = 3'b001,
        MATCH_11 = 3'b010,
        MATCH_110 = 3'b011,
        MATCH_1101 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and control signal assignments
    always @(*) begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = MATCH_1;
                else
                    next_state = IDLE;
            end
            MATCH_1: begin
                if (data == 1'b1)
                    next_state = MATCH_11;
                else
                    next_state = IDLE;
            end
            MATCH_11: begin
                if (data == 1'b0)
                    next_state = MATCH_110;
                else
                    next_state = IDLE;
            end
            MATCH_110: begin
                if (data == 1'b1)
                    next_state = MATCH_1101;
                else
                    next_state = IDLE;
            end
            MATCH_1101: begin
                shift_counter = 2'b00;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                shift_counter = shift_counter + 1;
                if (shift_counter == 2'b11)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
