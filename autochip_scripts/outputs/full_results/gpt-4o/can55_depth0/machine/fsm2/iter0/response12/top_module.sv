module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define states
    reg state, next_state;
    parameter A = 1'b0, B = 1'b1;

    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end

    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

    // Output the current state
    assign out = (state == B);

endmodule
