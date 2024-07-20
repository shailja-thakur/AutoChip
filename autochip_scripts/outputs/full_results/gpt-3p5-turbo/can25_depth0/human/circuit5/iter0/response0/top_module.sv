module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

    always @* begin
        case({a,b,c,d,e})
            20'b___00 : q = b;
            20'b___01 : q = e;
            20'b___10 : q = a;
            20'b___11 : q = d;
            default : q = f;
        endcase
    end

endmodule
