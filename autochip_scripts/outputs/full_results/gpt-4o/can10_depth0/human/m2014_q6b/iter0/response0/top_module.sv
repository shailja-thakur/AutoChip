module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // A -> B (if w=0) or A
            3'b001: Y2 = w; // B -> C (if w=0) or D (if w=1)
            3'b010: Y2 = 0; // C -> E (if w=0) or D
            3'b011: Y2 = ~w; // D -> F (if w=0) or A
            3'b100: Y2 = 1; // E -> E (if w=0) or D
            3'b101: Y2 = 0; // F -> C (if w=0) or D
            default: Y2 = 1'b0; // Default case to handle any illegal state
        endcase
    end
endmodule
