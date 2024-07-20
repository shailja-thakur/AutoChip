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
    typedef enum reg [2:0] {
        IDLE,
        S1,
        S11,
        S110,
        S1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    // State registers
    state_t current_state, next_state;
    reg [1:0] shift_counter;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 0;
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (current_state)
            IDLE: begin
                if (data) next_state = S1;
                else next_state = IDLE;
            end

            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end

            S11: begin
                if (!data) next_state = S110;
                else next_state = IDLE;
            end

            S110: begin
                if (data) next_state = S1101;
                else next_state = IDLE;
            end

            S1101: begin
                if (data) next_state = S1;
                else begin
                    next_state = SHIFT;
                    shift_counter = 0;
                end
            end

            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 2'b11) next_state = COUNT;
                else next_state = SHIFT;
            end

            COUNT: begin
                counting = 1;
                if (done_counting) next_state = DONE;
                else next_state = COUNT;
            end

            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
                else next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
