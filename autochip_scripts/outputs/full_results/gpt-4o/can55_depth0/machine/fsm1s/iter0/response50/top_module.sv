module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declaration
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    // Combinational logic for next state
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic based on state
    always @(state) begin
        case(state)
            A: out = 0;
            B: out = 1;
            default: out = 1;
        endcase
    end
endmodule
