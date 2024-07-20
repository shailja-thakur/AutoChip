module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // Next state logic (combinational)
    always @(*) begin
        case (current_state)
            A: next_state = (j == 1'b1) ? B : A;
            B: next_state = (k == 1'b1) ? A : B;
            default: next_state = A; // Default state
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A; // Reset state
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end
endmodule
