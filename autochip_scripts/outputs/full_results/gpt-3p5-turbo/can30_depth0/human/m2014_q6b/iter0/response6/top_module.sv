module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define the next-state logic for y[2]
    always @ (*) begin
        case (y)
            3'b000: Y2 = (w == 1) ? 0 : 0; // A state
            3'b001: Y2 = (w == 1) ? 1 : 0; // B state
            3'b010: Y2 = (w == 1) ? 0 : 0; // C state
            3'b011: Y2 = (w == 1) ? 1 : 0; // D state
            3'b100: Y2 = (w == 1) ? 0 : 1; // E state
            3'b101: Y2 = (w == 1) ? 1 : 0; // F state
            default: Y2 = 0;
        endcase
    end

endmodule
