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
            A: Y2 = 1'b0; // y2 is 0 for state A (000)
            B: Y2 = w;    // y2 depends on w for state B (001)
            C: Y2 = 1'b0; // y2 is 0 for state C (010)
            D: Y2 = 1'b1; // y2 is 1 for state D (011)
            E: Y2 = 1'b0; // y2 is 0 for state E (100)
            F: Y2 = 1'b0; // y2 is 0 for state F (101)
            default: Y2 = 1'b0;
        endcase
    end

endmodule
