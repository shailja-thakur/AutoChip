module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum reg { A, B } state_t;
    state_t state, next_state;

    // Combinational block to determine the next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default state
        endcase
    end

    // Clocked block to update the state based on the clock and reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        out = (state == B);
    end

endmodule
