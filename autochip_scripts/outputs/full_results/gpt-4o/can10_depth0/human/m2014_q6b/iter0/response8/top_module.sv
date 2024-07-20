module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // state encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    always @(*) begin
        case (y)
            A: Y2 = 1'b0; // Default value; remains same regardless of the input w
            B: Y2 = (w == 1'b0) ? 1'b0 : 1'b1;
            C: Y2 = 1'b0; // Default value; remains same regardless of the input w
            D: Y2 = (w == 1'b0) ? 1'b1 : 1'b0;
            E: Y2 = 1'b1; // Default value; remains same regardless of the input w
            F: Y2 = 1'b1; // Default value; remains same regardless of the input w
            default: Y2 = 1'b0; // Default case
        endcase
    end

endmodule
