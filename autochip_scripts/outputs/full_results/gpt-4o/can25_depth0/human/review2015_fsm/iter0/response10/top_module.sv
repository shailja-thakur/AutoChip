module top_module (
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    typedef enum reg [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4,
        SHIFT,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // State transitions
    always @(*) begin
        next_state = state; // Default to hold state
        
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (data) next_state = S1;
            end
            
            S1: begin
                if (data) next_state = S2;
                else next_state = IDLE;
            end
            
            S2: begin
                if (!data) next_state = S3;
                else next_state = IDLE;
            end
            
            S3: begin
                if (data) next_state = S4;
                else next_state = IDLE;
            end
            
            S4: begin
                if (data) next_state = SHIFT;
                else next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (done_counting) next_state = COUNT;
            end
            
            COUNT: begin
                counting = 1;
                if (done_counting) next_state = DONE;
            end
            
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
