module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // State definitions
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // State register update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) state <= B; // Initial state is B
        else state <= next_state;
    end

    // Output assignment
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
