module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = w ? 0 : 0;  // A to A, A to B
            3'b001: Y2 = w ? 1 : 0;  // B to D, B to C 
            3'b010: Y2 = w ? 1 : 1;  // C to D, C to E
            3'b011: Y2 = w ? 0 : 0;  // D to A, D to F
            3'b100: Y2 = 1;          // E to D, E to E 
            3'b101: Y2 = w ? 0 : 1;  // F to D, F to C
            default: Y2 = 1'bx;      // Undefined state
        endcase
    end
endmodule
