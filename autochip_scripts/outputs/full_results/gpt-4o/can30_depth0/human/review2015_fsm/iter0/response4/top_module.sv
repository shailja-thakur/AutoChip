module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum reg [2:0] {
        IDLE,
        SHIFT,
        WAIT_COUNT,
        DONE,
        ACK_WAIT
    } state_t;

    state_t state, next_state;
    reg [3:0] pattern_shift;
    reg [1:0] shift_counter;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (pattern_shift == 4'b1101) 
                    next_state = SHIFT;
                else 
                    next_state = IDLE;
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
            
            SHIFT: begin
                if (shift_counter == 2'b11)
                    next_state = WAIT_COUNT;
                else 
                    next_state = SHIFT;
                shift_ena = 1;
                counting = 0;
                done = 0;
            end
            
            WAIT_COUNT: begin
                if (done_counting) 
                    next_state = DONE;
                else 
                    next_state = WAIT_COUNT;
                shift_ena = 0;
                counting = 1;
                done = 0;
            end
            
            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = ACK_WAIT;
                shift_ena = 0;
                counting = 0;
                done = 1;
            end
            
            ACK_WAIT: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = ACK_WAIT;
                shift_ena = 0;
                counting = 0;
                done = 1;
            end
            
            default: begin
                next_state = IDLE;
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'b0;
            shift_counter <= 2'b0;
        end else begin
            state <= next_state;
            if (shift_ena)
                shift_counter <= shift_counter + 1'b1;
            else
                shift_counter <= 2'b0;
            pattern_shift <= {pattern_shift[2:0], data};
        end
    end
endmodule
