module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states for the finite state machine
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t current_state, next_state;
    reg [1:0] shift_counter;

    // State Transition (Sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 0;
            end
        end
    end

    // Next State Logic (Combinational)
    always_comb begin
        // Default assignments
        next_state = current_state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (current_state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 2'd3)
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
