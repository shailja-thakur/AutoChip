module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;

    // Current and next state variables
    reg current_state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (current_state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
