module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum reg { A = 1'b0, B = 1'b1 } state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // Default to state B
        endcase
    end

    // State update logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Asynchronous reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1; // Default to output 1 in state B
        endcase
    end
endmodule
