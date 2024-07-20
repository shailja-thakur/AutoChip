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
        S_IDLE        = 3'b000,
        S_DETECT_1    = 3'b001,
        S_DETECT_11   = 3'b010,
        S_DETECT_110  = 3'b011,
        S_DETECT_1101 = 3'b100,
        S_SHIFT       = 3'b101,
        S_COUNT       = 3'b110,
        S_DONE        = 3'b111
    } state_t;

    // State registers
    state_t state, next_state;

    // Counter for shift_ena
    logic [2:0] shift_counter;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Combinational logic for state transition
    always_comb begin
        // Default outputs
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            S_IDLE: begin
                if (data)
                    next_state = S_DETECT_1;
            end
            S_DETECT_1: begin
                if (data)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (data)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_1101: begin
                if (data)
                    next_state = S_SHIFT;
                else
                    next_state = S_IDLE;
            end
            S_SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3'd3) // After 4 clock cycles
                    next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1;
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end

    // Shift counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 3'b0;
        end
        else if (state == S_SHIFT) begin
            if (shift_counter == 3'd3)
                shift_counter <= 3'b0;
            else
                shift_counter <= shift_counter + 1;
        end
        else begin
            shift_counter <= 3'b0;
        end
    end
endmodule
