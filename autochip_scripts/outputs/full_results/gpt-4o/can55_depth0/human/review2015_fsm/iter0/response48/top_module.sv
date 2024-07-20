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
    typedef enum logic [3:0] {
        S_RESET        = 4'd0,
        S_WAIT_1       = 4'd1,
        S_WAIT_11      = 4'd2,
        S_WAIT_110     = 4'd3,
        S_WAIT_1101    = 4'd4,
        S_SHIFT_0      = 4'd5,
        S_SHIFT_1      = 4'd6,
        S_SHIFT_2      = 4'd7,
        S_SHIFT_3      = 4'd8,
        S_COUNT        = 4'd9,
        S_DONE         = 4'd10
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_RESET;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S_RESET: begin
                if (reset)
                    next_state = S_WAIT_1;
            end
            S_WAIT_1: begin
                if (data == 1'b1)
                    next_state = S_WAIT_11;
            end
            S_WAIT_11: begin
                if (data == 1'b0)
                    next_state = S_WAIT_1;
                else if (data == 1'b1)
                    next_state = S_WAIT_110;
            end
            S_WAIT_110: begin
                if (data == 1'b1)
                    next_state = S_WAIT_11;
                else if (data == 1'b0)
                    next_state = S_WAIT_1101;
            end
            S_WAIT_1101: begin
                if (data == 1'b1)
                    next_state = S_WAIT_110;
                else if (data == 1'b0)
                    next_state = S_SHIFT_0;
            end
            S_SHIFT_0: next_state = S_SHIFT_1;
            S_SHIFT_1: next_state = S_SHIFT_2;
            S_SHIFT_2: next_state = S_SHIFT_3;
            S_SHIFT_3: next_state = S_COUNT;
            S_COUNT: begin
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_WAIT_1;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            case (state)
                S_SHIFT_0, S_SHIFT_1, S_SHIFT_2, S_SHIFT_3: shift_ena <= 1'b1;
                S_COUNT: counting <= 1'b1;
                S_DONE: done <= 1'b1;
            endcase
        end
    end

endmodule
