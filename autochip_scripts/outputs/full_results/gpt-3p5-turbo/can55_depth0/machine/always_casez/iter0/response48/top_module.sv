module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez(in)
            8'bzzzzzzz1 : pos <= 3'b0;
            8'bz0zzzzzz : pos <= 3'b1;
            8'bz1zzzzzz : pos <= 3'b6;
            8'bz11zzzzz : pos <= 3'b2;
            8'bz111zzzz : pos <= 3'b3;
            8'bz1111zzz : pos <= 3'b4;
            8'bz11111zz : pos <= 3'b5;
            8'bz111111z : pos <= 3'b7;
            default : pos <= 3'b0;
        endcase
    end
endmodule
