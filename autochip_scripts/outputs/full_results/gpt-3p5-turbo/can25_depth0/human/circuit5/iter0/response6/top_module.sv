module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case ({a,b,c,d,e})
        {4'b0000, 4'b0000}: q = 4'b0000;  // output q is 0000 when a, b, c, d, e are all 0
        {a,b,4'b0000,d,e}: q = b;  // output q is value of b when c is 0
        {a,b,4'b0001,d,e}: q = e;  // output q is value of e when c is 1
        {a,b,4'b0010,d,e}: q = a;  // output q is value of a when c is 2
        {a,b,4'b0011,d,e}: q = d;  // output q is value of d when c is 3
        {a,b,4'b01xx,d,e}: q = 4'b1111;  // output q is 1111 when c is between 4 and 7 (inclusive)
        {a,b,4'b1xxx,d,e}: q = 4'd15;  // output q is 15 when c is between 8 and 15 (inclusive)
    endcase
end

endmodule
