module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    
always @(in) begin
    casez(in)
        8'bzzzzzzz0: pos <= 3'b1;
        8'bzzzzzzz1: pos <= 3'b0;
        8'bz1zzzzzz: pos <= 3'b6;
        8'bz0zzzzzz: pos <= 3'b5;
        8'bz00zzzzz: pos <= 3'b4;
        8'bz000zzzz: pos <= 3'b3;
        8'bz0000zzz: pos <= 3'b2;
        8'bz00000zz: pos <= 3'b1;
        default: pos <= 3'b0;
    endcase
end

endmodule
