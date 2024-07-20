module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [0:0] { A = 1'b0, B = 1'b1 } state_t;
    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end
endmodule
