module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @* begin
    case(a)
        0: q = 16'h1232;
        1: q = 16'hAF60;
        2: q = 16'h27E5;
        3: q = 16'h59DE;
        4: q = 16'h206A;
        5: q = 16'h641E;
        6: q = 16'hC52E;
        7: q = 16'h2F79;
    endcase
end

endmodule
