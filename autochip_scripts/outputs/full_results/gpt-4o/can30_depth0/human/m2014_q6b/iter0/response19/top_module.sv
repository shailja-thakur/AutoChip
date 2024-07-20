module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // State encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0;  // y[2] for state A is 0
            B: 
                if (w == 1'b0)
                    Y2 = 1'b1;  // state C
                else
                    Y2 = 1'b1;  // state D
            C: 
                if (w == 1'b0)
                    Y2 = 1'b0;  // state E
                else
                    Y2 = 1'b1;  // state D
            D:
                if (w == 1'b0)
                    Y2 = 1'b1;  // state F
                else
                    Y2 = 1'b0;  // state A
            E: Y2 = 1'b0;  // y[2] for state E is 0
            F: 
                if (w == 1'b0)
                    Y2 = 1'b0;  // state C
                else
                    Y2 = 1'b1;  // state D
            default: Y2 = 1'b0; // default case
        endcase
    end
endmodule
