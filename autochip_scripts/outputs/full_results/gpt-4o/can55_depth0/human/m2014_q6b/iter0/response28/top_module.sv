module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // State encoding
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 0; // A to B or A based on w, both have Y2=0
            B: Y2 = w; // B to D if w=1, 0 otherwise
            C: Y2 = 1; // C to D if w=1, 0 otherwise, but next state will make Y2=1
            D: Y2 = 0; // D to F or A, both have Y2=0
            E: Y2 = 1; // E stays or goes to D, both have Y2=1
            F: Y2 = w; // F to D if w=1, C otherwise
            default: Y2 = 0; // default case
        endcase
    end

endmodule
