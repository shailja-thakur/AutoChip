module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000; // Initialize state to A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'b000: // State A
            if (x)
                next_state = 3'b001; // B
            else
                next_state = 3'b000; // A
        3'b001: // State B
            if (x)
                next_state = 3'b100; // E
            else
                next_state = 3'b001; // B
        3'b010: // State C
            if (x)
                next_state = 3'b001; // B
            else
                next_state = 3'b010; // C
        3'b011: // State D
            if (x)
                next_state = 3'b010; // C
            else
                next_state = 3'b001; // B
        3'b100: // State E
            if (x)
                next_state = 3'b100; // E
            else
                next_state = 3'b011; // D
        default:
            next_state = 3'b000; // A
    endcase

    z = (state == 3'b011 || state == 3'b100); // Output z is high when in state D or E
end

endmodule
