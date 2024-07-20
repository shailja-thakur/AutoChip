module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*)
begin
    case({a,b,c,d,e})
        4'b0001: q = b;
        4'b0010: q = e;
        4'b1111: q = b; // To handle case 'f'
        4'b1000: q = a;
        4'b1000x: q = d[3:0];
        default: q = 4'b1111; // To handle all other cases
    endcase
end

endmodule
