module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    always @(*) begin
        case (y)
            3'b000: Y2 = (w == 0) ? 1'b0 : 1'b0; // A: next state B or A
            3'b001: Y2 = (w == 0) ? 1'b0 : 1'b1; // B: next state C or D
            3'b010: Y2 = (w == 0) ? 1'b1 : 1'b1; // C: next state E or D
            3'b011: Y2 = (w == 0) ? 1'b1 : 1'b0; // D: next state F or A
            3'b100: Y2 = (w == 0) ? 1'b0 : 1'b1; // E: next state E or D
            3'b101: Y2 = (w == 0) ? 1'b0 : 1'b1; // F: next state C or D
            default: Y2 = 1'b0;                  // default case
        endcase
    end

endmodule
