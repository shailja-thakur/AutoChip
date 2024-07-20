module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case(y)
            3'b000: begin
                if (w)
                    Y2 = 0;
                else
                    Y2 = 0;
            end
            3'b001: begin
                if (w)
                    Y2 = 1;
                else
                    Y2 = 1;
            end
            3'b010: begin
                if (w)
                    Y2 = 0;
                else
                    Y2 = 1;
            end
            3'b011: begin
                if (w)
                    Y2 = 1;
                else
                    Y2 = 0;
            end
            3'b100: begin
                if (w)
                    Y2 = 1;
                else
                    Y2 = 0;
            end
            3'b101: begin
                if (w)
                    Y2 = 0;
                else
                    Y2 = 1;
            end
            default: begin
                Y2 = 0;
            end
        endcase
    end
endmodule
