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

    // State definition
    typedef enum reg [2:0] {
        IDLE    = 3'd0,
        S1      = 3'd1,
        S2      = 3'd2,
        S3      = 3'd3,
        S4      = 3'd4,
        SHIFT   = 3'd5,
        COUNT   = 3'd6,
        DONE    = 3'd7
    } state_t;
    
    // State registers
    state_t state, next_state;
    reg [3:0] shift_counter;
    
    // Sequential state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic and state transitions
    always @(*) begin
        // Default values (to avoid latches)
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (data == 1'b1)      next_state = S1;
                else                   next_state = IDLE;
            end
            
            S1: begin
                if (data == 1'b1)      next_state = S2;
                else                   next_state = IDLE;
            end
            
            S2: begin
                if (data == 1'b0)      next_state = S3;
                else                   next_state = IDLE;
            end
            
            S3: begin
                if (data == 1'b1)      next_state = S4;
                else                   next_state = IDLE;
            end
            
            S4: begin
                if (data == 1'b1)      next_state = SHIFT;
                else                   next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 4) begin
                    next_state = COUNT;
                end
                else begin
                    next_state = SHIFT;
                end
            end
            
            COUNT: begin
                counting = 1'b1;
                if (done_counting)     next_state = DONE;
                else                   next_state = COUNT;
            end
            
            DONE: begin
                done = 1'b1;
                if (ack)               next_state = IDLE;
                else                   next_state = DONE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Shift counter for SHIFT state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 4'd0;
        end
        else if (state == SHIFT) begin
            shift_counter <= shift_counter + 1;
        end
        else begin
            shift_counter <= 4'd0;
        end
    end

endmodule
