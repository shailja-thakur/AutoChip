module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Define state codes
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 0; // A always transitions to 0 state for Y2
            B: Y2 = w ? 1 : 0; // Based on input w
            C: Y2 = 1; // C always transitions to 1 state for Y2
            D: Y2 = 1; // D always transitions to 1 state for Y2
            E: Y2 = 1; // E always transitions to 1 state for Y2
            F: Y2 = w ? 1 : 0; // Based on input w
            default: Y2 = 0; // Default case (shouldn't happen)
        endcase
    end
endmodule
