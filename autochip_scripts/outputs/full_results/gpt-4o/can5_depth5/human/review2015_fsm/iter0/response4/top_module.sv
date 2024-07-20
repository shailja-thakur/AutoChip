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
    
    // State declaration
    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S_DETECT1 = 3'd1,
        S_DETECT2 = 3'd2,
        S_DETECT3 = 3'd3,
        S_DETECT4 = 3'd4,
        S_SHIFT = 3'd5,
        S_COUNT = 3'd6,
        S_DONE = 3'd7
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DETECT1;
            end
            S_DETECT1: begin
                if (data == 1'b1)
                    next_state = S_DETECT2;
                else
                    next_state = S_IDLE;
            end
            S_DETECT2: begin
                if (data == 1'b0)
                    next_state = S_DETECT3;
                else
                    next_state = S_IDLE;
            end
            S_DETECT3: begin
                if (data == 1'b1)
                    next_state = S_DETECT4;
                else
                    next_state = S_IDLE;
            end
            S_DETECT4: begin
                if (data == 1'b1)
                    next_state = S_SHIFT;
                else
                    next_state = S_IDLE;
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'd3)
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

    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 3'd0;
        end else if (state == S_SHIFT) begin
            if (shift_ena)
                shift_counter <= shift_counter + 1;
        end else begin
            shift_counter <= 3'd0;
        end
    end

endmodule
