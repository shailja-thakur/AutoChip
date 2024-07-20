module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    case ({a,b,c,d,e})
        4'd0: q = b; // a=b=0
        4'd1: q = e; // a=b=1
        4'd2: q = a; // a=b=2
        4'd3: q = d; // a=b=3
        4'd4: q = f; // a=b=4
        4'd5: q = f; // a=b=5
        4'd6: q = f; // a=b=6
        4'd7: q = f; // a=b=7
        4'd8: q = f; // a=b=8
        4'd9: q = f; // a=b=9
        4'd10: q = f; // a=b=a
        4'd11: q = f; // a=b=b
        4'd12: q = f; // a=b=c
        4'd13: q = f; // a=b=d
        4'd14: q = f; // a=b=e
        4'd15: q = f; // a=b=f
    endcase
end

endmodule
