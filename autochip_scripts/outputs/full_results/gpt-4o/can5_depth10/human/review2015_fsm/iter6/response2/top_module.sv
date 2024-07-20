module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    // State encoding
    typedef enum logic [3:0] {
        S_IDLE = 4'b0000,
        S_DET1 = 4'b0001,
        S_DET2 = 4'b0010,
        S_DET3 = 4'b0011,
        S_DET4 = 4'b0100,
        S_SHIFT = 4'b0101,
        S_WAIT_COUNT = 4'b0110,
        S_DONE = 4'b0111
    } state_t;
    
    state_t current_state, next_state;
    
    // Counter for shifting bits
    reg [1:0] shift_counter;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S_IDLE;
            shift_counter <= 2'b0;
        end else begin
            current_state <= next_state;
            
            if (current_state == S_SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 2'b0;
        end
    end
    
    // Next state logic
    always_comb begin
        // Default values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state;

        case(current_state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DET1;
            end
            S_DET1: begin
                if (data == 1'b1)
                    next_state = S_DET2;
                else
                    next_state = S_IDLE;
            end
            S_DET2: begin
                if (data == 1'b0)
                    next_state = S_DET3;
                else
                    next_state = S_IDLE;
            end
            S_DET3: begin
                if (data == 1'b1)
                    next_state = S_DET4;
                else
                    next_state = S_IDLE;
            end
            S_DET4: begin
                next_state = S_SHIFT;
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11)
                    next_state = S_WAIT_COUNT;
            end
            S_WAIT_COUNT: begin
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

endmodule
