module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// State Definitions using One-Hot Encoding
localparam A = 6'b000001;
localparam B = 6'b000010;
localparam C = 6'b000100;
localparam D = 6'b001000;
localparam E = 6'b010000;
localparam F = 6'b100000;

// Derive Y1 and Y3 using the state transitions based on the given state diagram

assign Y1 = (y == A && w == 1) || (y == C && w == 1);
assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == F && w == 0);

endmodule
