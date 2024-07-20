module top_module (
    input [6:1] y,
    input w,
    output Y2,  // Next state bit 2
    output Y4   // Next state bit 4
);

    // State encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Determine next state logic for bit Y2 and Y4
    assign Y2 = (y == A & w == 0) | (y == B & w == 0) | (y == F & w == 0);
    assign Y4 = (y == B & w == 1) | (y == C & w == 1) | (y == F & w == 1);

endmodule
