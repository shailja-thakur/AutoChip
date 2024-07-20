module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Next-state logic for y[2]
    always @(*)
    begin
        case (y)
            3'b000: Y2 = w; // A (0) --0--> B
            3'b001: Y2 = y[1]; // A (0) --1--> A
            3'b010: Y2 = w; // B (0) --0--> C
            3'b011: Y2 = w; // B (0) --1--> D
            3'b100: Y2 = w; // C (0) --0--> E
            3'b101: Y2 = w; // C (0) --1--> D
            3'b110: Y2 = w; // D (0) --0--> F
            3'b111: Y2 = y[1]; // D (0) --1--> A
        endcase
    end

endmodule
