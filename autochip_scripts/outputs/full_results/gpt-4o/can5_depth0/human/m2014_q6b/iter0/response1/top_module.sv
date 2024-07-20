module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // State encoding 
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;
    
    always @(*) begin
        case (y)
            A: Y2 = (w == 1'b0) ? 1'b0 : 1'b0; // A -> B or A -> A
            B: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // B -> C or B -> D
            C: Y2 = (w == 1'b0) ? 1'b1 : 1'b1; // C -> E or C -> D
            D: Y2 = (w == 1'b0) ? 1'b1 : 1'b0; // D -> F or D -> A
            E: Y2 = 1'b0;                      // E -> E or E -> D
            F: Y2 = 1'b1;                      // F -> C or F -> D
            default: Y2 = 1'b0;
        endcase
    end
endmodule
