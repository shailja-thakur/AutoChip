module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // States
    typedef enum logic {A, B} state_t;
    state_t state, next_state;
    
    // Next state logic
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // State update on clock edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
