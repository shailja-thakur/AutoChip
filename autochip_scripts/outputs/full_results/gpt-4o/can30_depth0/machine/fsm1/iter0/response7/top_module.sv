module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    // State definitions
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;
        endcase
    end
    
    // State update on clock or async reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B);
endmodule
