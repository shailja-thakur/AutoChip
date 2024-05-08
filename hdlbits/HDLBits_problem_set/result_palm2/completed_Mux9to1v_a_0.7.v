module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    always @(sel or a or b or c or d or e or f or g or h or i) begin
        case (sel)
            0: out <= a;
            1: out <= b;
            2: out <= c;
            3: out <= d;
            4: out <= e;
            5: out <= f;
            6: out <= g;
            7: out <= h;
            8: out <= i;
            9: out <= 1'hFF;
            10: out <= 1'hFF;
            11: out <= 1'hFF;
            12: out <= 1'hFF;
            13: out <= 1'hFF;
            14: out <= 1'hFF;
            15: out <= 1'hFF;
        endcase
    end

endmodule