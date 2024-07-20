module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default state
        endcase
    end

    // Clocked logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
