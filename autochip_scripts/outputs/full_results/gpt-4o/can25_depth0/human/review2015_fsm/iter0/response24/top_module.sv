module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declaration
    typedef enum reg [2:0] {
        S_IDLE,
        S_DETECT_1,
        S_DETECT_11,
        S_DETECT_110,
        S_DETECT_1101,
        S_SHIFT,
        S_COUNT,
        S_DONE
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Combinational logic for state transition and outputs
    always @(*) begin
        // Default output values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case (state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1;
            end

            S_DETECT_1: begin
                if (data == 1'b1)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end

            S_DETECT_11: begin
                if (data == 1'b0)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end

            S_DETECT_110: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end

            S_DETECT_1101: begin
                shift_ena = 1'b1;
                next_state = S_SHIFT;
            end

            S_SHIFT: begin
                if (shift_counter == 3) begin
                    next_state = S_COUNT;
                end else begin
                    shift_ena = 1'b1;
                end
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

            default: next_state = S_IDLE;
        endcase
    end

    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 3'b0;
        else if (state == S_SHIFT)
            shift_counter <= shift_counter + 1;
        else
            shift_counter <= 3'b0;
    end
    
endmodule
