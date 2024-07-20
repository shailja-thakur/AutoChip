module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) state <= 3'b001; // State A
    else state <= next_state;
end

always @(*) begin
    case (state)
        3'b001: // State A
            if (x) next_state = 3'b010; // B
            else next_state = 3'b001; // A
        3'b010: // State B
            if (x) next_state = 3'b101; // E
            else next_state = 3'b010; // B
        3'b011: // State C
            if (x) next_state = 3'b010; // B
            else next_state = 3'b011; // C
        3'b100: // State D
            if (x) next_state = 3'b011; // C
            else next_state = 3'b010; // B
        3'b101: // State E
            if (x) next_state = 3'b101; // E
            else next_state = 3'b100; // D
        default:
            next_state = 3'b001; // A
    endcase

    z = (state == 3'b100 || state == 3'b101); // Output z is high when in state D or E
end

endmodule
