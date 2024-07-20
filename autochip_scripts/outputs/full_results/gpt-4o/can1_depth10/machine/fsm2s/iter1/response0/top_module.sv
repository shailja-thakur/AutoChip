module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end
    
endmodule
