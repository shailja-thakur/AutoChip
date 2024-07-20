module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] kmap;

always_comb begin
    case (x)
        4'b0000: kmap = 1'b1;
        4'b0001: kmap = 1'b0;
        4'b0011: kmap = 1'b0;
        4'b0010: kmap = 1'b1;
        4'b0110: kmap = 1'b0;
        4'b0111: kmap = 1'b0;
        4'b0101: kmap = 1'b0;
        4'b0100: kmap = 1'b0;
        4'b1100: kmap = 1'b1;
        4'b1101: kmap = 1'b1;
        4'b1111: kmap = 1'b1;
        4'b1110: kmap = 1'b0;
        4'b1010: kmap = 1'b1;
        4'b1011: kmap = 1'b1;
        4'b1001: kmap = 1'b0;
        4'b1000: kmap = 1'b1;
        default: kmap = 1'b0;
    endcase
    
    f = kmap;
end

endmodule
