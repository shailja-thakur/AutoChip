module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);  
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // default case to handle unexpected values
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        case (state)
            A, B, C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0; // default case to handle unexpected values
        endcase
    end
endmodule
