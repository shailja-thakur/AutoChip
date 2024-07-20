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
            20'b0000110 : q <= b; // a=0, b=0, c=0, d=1, e=1
            20'b0100111 : q <= e; // a=0, b=1, c=0, d=1, e=1
            20'b1000100 : q <= a; // a=1, b=0, c=0, d=1, e=0
            20'b1100101 : q <= d; // a=1, b=1, c=0, d=1, e=0
            default : q <= f; // all other cases
        endcase
    end
    
endmodule
