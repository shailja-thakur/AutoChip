module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // A: 000
            3'b001: Y2 = ~w;   // B: 001 -> 0 for state C (010), and 1 for state D (011)
            3'b010: Y2 = 1'b1; // C: 010 always goes to 0XX (E: 100 or D: 011) which have Y2 == 1
            3'b011: Y2 = 1'b0; // D: 011 -> 0 for state F (101), and 1 for state A (000)
            3'b100: Y2 = 1'b1; // E: 100 remains in E or goes to D (Y2 == 1 for both conditions)
            3'b101: Y2 = 1'b0; // F: 101 -> 0 for state C (010), and 1 for state D (011)
            default: Y2 = 1'b0; // default case
        endcase
    end
endmodule
