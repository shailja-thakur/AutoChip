module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: next_state = (in) ? 2'b01 : 2'b00; // State A
        2'b01: next_state = (in) ? 2'b01 : 2'b10; // State B
        2'b10: next_state = (in) ? 2'b11 : 2'b00; // State C
        2'b11: next_state = (in) ? 2'b01 : 2'b10; // State D
        default: next_state = 2'b00; // Default to State A
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to State A
    else
        state <= next_state;
end

always @(state) begin
    out = (state == 2'b11); // Set output when in State D
end

endmodule
