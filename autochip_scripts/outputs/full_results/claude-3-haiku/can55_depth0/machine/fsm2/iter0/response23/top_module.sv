module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// Combinational logic for next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j == 1'b1)
                next_state = 1'b1; // Next state is B
            else
                next_state = 1'b0; // Next state is A
        1'b1: // State B
            if (k == 1'b1)
                next_state = 1'b0; // Next state is A
            else
                next_state = 1'b1; // Next state is B
    endcase
end

// Clocked logic for state update
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= 1'b0; // Reset to state A
    else
        state <= next_state;
end

// Output logic
assign out = (state == 1'b1); // Out is high when in state B

endmodule
