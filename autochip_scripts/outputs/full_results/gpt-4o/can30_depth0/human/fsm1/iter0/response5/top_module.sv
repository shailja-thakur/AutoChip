module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [0:0] {A=1'b0, B=1'b1} state_t;
    state_t state, next_state;

    // State transitions
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // default case to handle unexpected conditions
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1; // default output for unexpected conditions
        endcase
    end
endmodule
