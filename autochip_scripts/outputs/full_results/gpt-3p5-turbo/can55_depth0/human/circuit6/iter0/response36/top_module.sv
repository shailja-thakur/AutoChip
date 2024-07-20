module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @* begin
    case (a)
        0: q = 1232;
        1: q = 0xaee0;
        2: q = 0x27d4;
        3: q = 0x5a0e;
        4: q = 0x2066;
        5: q = 0x64ce;
        6: q = 0xc526;
        7: q = 0x2f19;
        default: q = 0;
    endcase
end

endmodule
