module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    always @* begin
        case ({a, b, c, d})
            4'b0010, 4'b0111, 4'b1111: begin
                out_sop = 1;
                out_pos = 1;
            end
            default: begin
                out_sop = 0;
                out_pos = 0;
            end
        endcase
    end

endmodule
