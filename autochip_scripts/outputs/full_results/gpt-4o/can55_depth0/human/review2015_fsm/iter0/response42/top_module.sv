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
        IDLE = 3'd0,
        SHIFT = 3'd1,
        COUNT = 3'd2,
        DONE = 3'd3,
        ACK_WAIT = 3'd4
    } state_t;
    
    state_t state, next_state;
    reg [2:0] pattern_shift;
    reg [1:0] shift_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 3'd0;
            shift_count <= 2'd0;
        end else begin
            state <= next_state;
            if (state == IDLE ||
                state == SHIFT)
                pattern_shift <= {pattern_shift[1:0], data};
            if (state == SHIFT)
                shift_count <= shift_count + 1;
            else if (state == IDLE)
                shift_count <= 2'd0;
        end
    end

    always_comb begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (pattern_shift == 3'b110 && data == 1'b1)
                    next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_count == 2'd3)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
