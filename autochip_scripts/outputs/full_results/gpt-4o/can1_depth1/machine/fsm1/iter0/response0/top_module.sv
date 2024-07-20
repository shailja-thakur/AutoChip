module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // States represented as two states A (0) and B (1)
    reg state, next_state;
    localparam A = 1'b0, B = 1'b1;

    // Update state on the rising edge of clk or areset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;   // Reset state to B
        end
        else begin
            state <= next_state;  // Update state
        end
    end

    // Determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // Default state
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
