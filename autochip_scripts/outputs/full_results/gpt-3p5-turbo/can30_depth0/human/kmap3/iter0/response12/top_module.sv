module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

    always @*
    begin
        case ({c, d})
            
            // d is don't-care
            2'b01, 2'b10, 2'b11:
                out = 1;
            
            // cd = 00
            2'b00:
                if (a == 1 && b == 1)
                    out = 1;
                else if (a == 1 && b == 0)
                    out = 0;
                else if (a == 0 && b == 1)
                    out = 1;
                else
                    out = d;
            
            // cd = 01
            2'b01:
                if (a == 1 && b == 0)
                    out = 0;
                else
                    out = d;
            
            // cd = 10
            2'b10:
                if (a == 0 && b == 1)
                    out = 1;
                else
                    out = d;
            
            // cd = 11
            2'b11:
                out = 1;
                
            default:
                out = 0;
        endcase
    end
endmodule
