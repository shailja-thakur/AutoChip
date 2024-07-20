module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    // State register
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
