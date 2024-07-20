module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: // State A
            if (w)
                Y2 = y[1];
            else
                Y2 = y[1];
        3'b001: // State B
            if (w)
                Y2 = y[2];
            else
                Y2 = y[2];
        3'b010: // State C
            if (w)
                Y2 = y[2];
            else
                Y2 = y[1];
        3'b011: // State D
            if (w)
                Y2 = y[1];
            else
                Y2 = y[2];
        3'b100: // State E
            if (w)
                Y2 = y[2];
            else
                Y2 = y[2];
        3'b101: // State F
            if (w)
                Y2 = y[2];
            else
                Y2 = y[1];
        default:
            Y2 = 1'bx;
    endcase
end

endmodule
