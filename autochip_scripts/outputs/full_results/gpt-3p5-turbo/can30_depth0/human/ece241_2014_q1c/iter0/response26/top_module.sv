module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg signed [7:0] a_signed;
    reg signed [7:0] b_signed;
    wire [7:0] s_abs;
    
    assign s[7] = a[7] ^ b[7];
    
    assign s_abs = a[7] ? (~a + 1) : a;
    assign overflow = (s_abs > (b[7] ? (~b + 1) : b)) ? 1'b1 : 1'b0;
    
    always @(a or b) begin
        a_signed = $signed(a);
        b_signed = $signed(b);
        s = a_signed + b_signed;
    end
    
endmodule
