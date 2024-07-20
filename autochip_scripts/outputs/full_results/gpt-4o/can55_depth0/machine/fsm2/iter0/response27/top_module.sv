module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational always block to determine the next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default case to handle any unforeseen conditions
        endcase
    end

    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
