module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0; // A
            3'b001: Y2 = w;    // B: if w==0 -> C, if w==1 -> D
            3'b010: Y2 = 1'b0; // C
            3'b011: Y2 = 1'b1; // D
            3'b100: Y2 = 1'b0; // E
            3'b101: Y2 = 1'b1; // F
            default: Y2 = 1'b0; // Default case to handle unexpected inputs
        endcase
    end

endmodule
