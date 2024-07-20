module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;

    state_t state, next_state;

    // State transition logic (combinatorial)
    always_comb begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (combinatorial)
    always_comb begin
        case (state)
            D: out = 1;
            default: out = 0;
        endcase
    end
endmodule
