module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
 
always @(in)
begin
    casez(in)
        8'bzzzzzz10 : pos = 3'b0;
        8'bzzzzz1zz : pos = 3'b1;
        8'bzzzz10zz : pos = 3'b2;
        8'bzzz1zzzz : pos = 3'b3;
        8'bzz10zzzz : pos = 3'b4;
        8'bz1zzzzzz : pos = 3'b5;
        8'bz10zzzzz : pos = 3'b6;
        8'b1zzzzzzz : pos = 3'b7;
        default     : pos = 3'b0;
    endcase
end
 
endmodule
