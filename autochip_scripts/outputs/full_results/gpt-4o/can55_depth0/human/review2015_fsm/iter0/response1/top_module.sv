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
        IDLE = 4'd0,
        S1 = 4'd1,
        S11 = 4'd2,
        S110 = 4'd3,
        S1101 = 4'd4,
        SHIFT = 4'd5,
        COUNT = 4'd6,
        DONE = 4'd7
    } state_t;

    state_t state, next_state;
    logic [2:0] shift_counter;

    // State transition logic (combinational)
    always_comb begin
        next_state = state; // Default to hold value
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = S1;
            end
            S1: begin
                if (data == 1'b1) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (data == 1'b0) next_state = S110;
                else next_state = IDLE;
            end
            S110: begin
                if (data == 1'b1) next_state = S1101;
                else next_state = IDLE;
            end
            S1101: begin
                shift_ena = 1'b1;
                next_state = (shift_counter == 3) ? COUNT : S1101;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

    // State flip-flops (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
        end
        else begin
            state <= next_state;
            if (shift_ena)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 0;
        end
    end
endmodule
