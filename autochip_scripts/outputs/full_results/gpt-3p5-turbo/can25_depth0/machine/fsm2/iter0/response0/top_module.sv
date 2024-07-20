module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define state enumeration
    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;

    // Combinational always block for determining next state
    always_comb
    begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
        endcase
    end

    // Clocked always block for updating state
    always_ff @(posedge clk)
    begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Assign out port based on current state
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
