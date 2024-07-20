module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    reg signed [7:0] a_signed;
    reg signed [7:0] b_signed;
    reg signed [7:0] s_signed;
    
    assign {overflow, s} = a_signed + b_signed;
    
    always @(a, b) begin
        a_signed = a;
        b_signed = b;
    end

endmodule
