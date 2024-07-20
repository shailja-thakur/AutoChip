module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // safe state default
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            A, B, C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0; // safe default
        endcase
    end

    // State update logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset to state A
        else
            state <= next_state;
    end

endmodule
