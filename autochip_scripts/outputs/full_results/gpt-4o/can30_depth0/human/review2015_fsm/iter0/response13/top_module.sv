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

    // Define states
    typedef enum reg [2:0] {
        STATE_IDLE,
        STATE_DETECT_1,
        STATE_DETECT_11,
        STATE_DETECT_110,
        STATE_DETECT_1101,
        STATE_SHIFT,
        STATE_COUNT,
        STATE_DONE
    } state_t;
    
    state_t state, next_state;
    reg [1:0] shift_counter;  // 2-bit counter to count 4 cycles during shifting

    // Sequential block for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational block for next state logic and output logic
    always @(*) begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            STATE_IDLE: begin
                if (data) 
                    next_state = STATE_DETECT_1;
            end
            STATE_DETECT_1: begin
                if (data)
                    next_state = STATE_DETECT_11;
                else
                    next_state = STATE_IDLE;
            end
            STATE_DETECT_11: begin
                if (data)
                    next_state = STATE_DETECT_110;
                else
                    next_state = STATE_IDLE;
            end
            STATE_DETECT_110: begin
                if (data)
                    next_state = STATE_DETECT_1101;
                else
                    next_state = STATE_IDLE;
            end
            STATE_DETECT_1101: begin
                next_state = STATE_SHIFT;
            end
            STATE_SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 2'd3) // After 4 cycles (0, 1, 2, 3)
                    next_state = STATE_COUNT;
            end
            STATE_COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = STATE_DONE;
            end
            STATE_DONE: begin
                done = 1;
                if (ack)
                    next_state = STATE_IDLE;
            end
        endcase
    end

    // Shift counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 0;
        end else if (state == STATE_SHIFT) begin
            if (shift_ena) begin
                shift_counter <= shift_counter + 1;
            end
        end else begin
            shift_counter <= 0;
        end
    end

endmodule
