module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state; // Update state on rising edge of clock
end

always @* begin
    case (state)
        2'b00: // State A
            if (in)
                next_state = 2'b01; // Next state is B if input is 1
            else
                next_state = 2'b00; // Next state is A if input is 0
        2'b01: // State B
            if (in)
                next_state = 2'b01; // Next state is B if input is 1
            else
                next_state = 2'b10; // Next state is C if input is 0
        2'b10: // State C
            if (in)
                next_state = 2'b11; // Next state is D if input is 1
            else
                next_state = 2'b00; // Next state is A if input is 0
        2'b11: // State D
            if (in)
                next_state = 2'b01; // Next state is B if input is 1
            else
                next_state = 2'b10; // Next state is C if input is 0
    endcase
end

assign out = (state == 2'b11); // Output is 1 when state is D

endmodule
