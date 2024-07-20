module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] { A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3 } state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: if (in) next_state = B;
               else next_state = A;
            B: if (in) next_state = B;
               else next_state = C;
            C: if (in) next_state = D;
               else next_state = A;
            D: if (in) next_state = B;
               else next_state = C;
            default: next_state = A; // Default state to avoid latches
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            A, B, C: out = 0;
            D: out = 1;
            default: out = 0;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
