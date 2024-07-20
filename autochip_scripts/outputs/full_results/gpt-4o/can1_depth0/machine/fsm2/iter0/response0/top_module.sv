module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State declaration
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational logic for state transitions
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Clocked always block for state updating
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 0;
        end else begin
            out <= (state == B);
        end
    end

endmodule
