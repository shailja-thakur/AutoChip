module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {A=1'b0, B=1'b1} state_t;
    state_t state, next_state;

    // Next state logic (Combinational)
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // State register logic (Sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
