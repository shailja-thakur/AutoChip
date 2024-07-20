module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);
    
    always @* begin
        case ({a, b, c, d, e})
            5'b0000: q = b;
            5'b0101: q = e;
            5'b1010: q = a;
            5'b1101: q = d;
            default: q = 4'b1111;
        endcase
    end

endmodule
