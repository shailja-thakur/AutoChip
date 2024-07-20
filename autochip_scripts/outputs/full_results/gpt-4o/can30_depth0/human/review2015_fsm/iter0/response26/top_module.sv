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
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        S1 = 3'd1,
        S2 = 3'd2,
        S3 = 3'd3,
        S4 = 3'd4,
        SHIFT = 3'd5,
        COUNT = 3'd6,
        DONE = 3'd7
    } state_t;

    state_t state, next_state;

    // Pattern detection
    reg [3:0] pattern;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0000;
        end
        else begin
            state <= next_state;
            if (state != COUNT && state != DONE && state != SHIFT) 
                pattern <= {pattern[2:0], data};
        end
    end

    always @(*) begin
        // Default output values
        shift_ena = 0;
        counting = 0;
        done = 0;

        next_state = state; // Default to stay in the same state

        case (state)
            IDLE: begin
                if (pattern == 4'b1101)
                    next_state = S1;
            end
            S1: begin
                next_state = S2;
                shift_ena = 1;
            end
            S2: begin
                next_state = S3;
                shift_ena = 1;
            end
            S3: begin
                next_state = S4;
                shift_ena = 1;
            end
            S4: begin
                next_state = SHIFT;
                shift_ena = 1;
            end
            SHIFT: begin
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
        endcase
    end
endmodule
