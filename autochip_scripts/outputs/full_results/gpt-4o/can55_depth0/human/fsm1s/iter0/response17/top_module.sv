module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    
    typedef enum logic [1:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;
    
    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (state)
            B: if (in) 
                next_state = B;
               else 
                next_state = A;
            A: if (in)
                next_state = A;
               else
                next_state = B;
        endcase
    end
    
    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1;
        else
            case (state)
                A: out <= 0;
                B: out <= 1;
            endcase
    end
    
endmodule
