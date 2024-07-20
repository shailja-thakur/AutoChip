module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire z;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state is A
    else if (w)
        case (state)
            3'b000: state <= 3'b001; // Transition from A to B when w is 1
            3'b001: state <= 3'b010; // Transition from B to C when w is 1
            3'b010: state <= 3'b100; // Transition from C to E when w is 1
            3'b011: state <= 3'b111; // Transition from D to F when w is 1
            3'b100: state <= 3'b100; // Transition from E to E when w is 1
            3'b101: state <= 3'b110; // Transition from F to C when w is 1
            default: state <= 3'b000; // Reset to state A for unhandled cases
        endcase
    else
        case (state)
            3'b000: state <= 3'b000; // Stay in state A when w is 0
            3'b001: state <= 3'b011; // Transition from B to D when w is 0
            3'b010: state <= 3'b011; // Transition from C to D when w is 0
            3'b011: state <= 3'b000; // Transition from D to A when w is 0
            3'b100: state <= 3'b011; // Transition from E to D when w is 0
            3'b101: state <= 3'b011; // Transition from F to D when w is 0
            default: state <= 3'b000; // Reset to state A for unhandled cases
        endcase
end

assign z = (state == 3'b100) || (state == 3'b101); // Set z to 1 when state is E or F

endmodule
