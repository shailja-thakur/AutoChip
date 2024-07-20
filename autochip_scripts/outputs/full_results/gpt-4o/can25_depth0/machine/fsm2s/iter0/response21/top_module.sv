module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [0:0] {A = 1'b0, B = 1'b1} state_t; 
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (j) 
                    next_state = B;
               else 
                    next_state = A;
            B: if (k) 
                    next_state = A;
               else 
                    next_state = B;
            default: next_state = A; // Default state to A
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
