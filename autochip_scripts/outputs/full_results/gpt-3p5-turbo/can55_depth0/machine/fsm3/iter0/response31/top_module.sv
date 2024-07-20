module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state; // Update state based on next_state
    
    case(state)
        2'b00: // State A
            if (in)
                next_state = 2'b01; // Next state is B
            else
                next_state = 2'b00; // Next state is A
        2'b01: // State B
            if (in)
                next_state = 2'b01; // Next state is B
            else
                next_state = 2'b10; // Next state is C
        2'b10: // State C
            if (in)
                next_state = 2'b11; // Next state is D
            else
                next_state = 2'b00; // Next state is A
        2'b11: // State D
            if (in)
                next_state = 2'b01; // Next state is B
            else
                next_state = 2'b10; // Next state is C
        default:
            next_state = 2'b00; // Default state is A
    endcase
end

always @(state) begin
    if (state == 2'b11)
        out = 1; // Output is 1 when in state D
    else
        out = 0;
end

endmodule
