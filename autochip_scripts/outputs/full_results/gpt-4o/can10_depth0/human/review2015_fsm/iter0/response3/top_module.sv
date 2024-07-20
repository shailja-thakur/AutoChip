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
    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        WAIT_COUNT,
        DONE,
        WAIT_ACK
    } state_t;
    
    state_t state, next_state;
    reg [1:0] shift_counter;
    
    // State transition logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
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
                shift_ena = 1'b1;
                if(shift_counter == 2'd3)
                    next_state = WAIT_COUNT;
            end
            
            WAIT_COUNT: begin
                counting = 1'b1;
                if(done_counting)
                    next_state = DONE;
            end
            
            DONE: begin
                done = 1'b1;
                if(ack)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // State and shift counter update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 2'd0;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                if (shift_counter == 2'd3)
                    shift_counter <= 2'd0;
                else
                    shift_counter <= shift_counter + 1'b1;
            end else begin
                shift_counter <= 2'd0;
            end
        end
    end

endmodule
