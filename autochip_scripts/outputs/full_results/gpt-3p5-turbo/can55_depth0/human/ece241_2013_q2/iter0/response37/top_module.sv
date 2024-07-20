module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    reg out_sop;
    reg out_pos;
    always @*
    begin
        case ({a, b, c, d})
            4'b0010:
            begin
                out_sop = 1'b1;
                out_pos = 1'b1;
            end
            4'b0111:
            begin
                out_sop = 1'b1;
                out_pos = 1'b1;
            end
            4'b1111:
            begin
                out_sop = 1'b1;
                out_pos = 1'b1;
            end
            default:
            begin
                out_sop = 1'b0;
                out_pos = 1'b0;
            end
        endcase
    end
endmodule
