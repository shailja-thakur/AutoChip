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
        IDLE        = 3'b000,
        PATTERN_1   = 3'b001,
        PATTERN_11  = 3'b010,
        PATTERN_110 = 3'b011,
        PATTERN_1101= 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_count <= shift_count + 1;
            end else if (state != SHIFT) begin
                shift_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = PATTERN_1;
            end
            PATTERN_1: begin
                if (data == 1'b1)
                    next_state = PATTERN_11;
                else
                    next_state = IDLE;
            end
            PATTERN_11: begin
                if (data == 1'b0)
                    next_state = PATTERN_110;
                else
                    next_state = IDLE;
            end
            PATTERN_110: begin
                if (data == 1'b1)
                    next_state = PATTERN_1101;
                else
                    next_state = IDLE;
            end
            PATTERN_1101: begin
                shift_ena = 1'b1;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 3)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
