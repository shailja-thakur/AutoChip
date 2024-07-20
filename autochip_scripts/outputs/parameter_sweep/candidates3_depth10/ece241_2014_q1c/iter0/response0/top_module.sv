module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    reg [7:0] s_reg;
    
    always @(a or b) begin
        s_reg <= a + b;
    end
    
    assign s = s_reg;
    
    assign overflow = (s_reg[7] != a[7] && s_reg[7] != b[7]);
    
endmodule
