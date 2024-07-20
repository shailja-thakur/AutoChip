module top_module (
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output overflow
);

    reg signed [7:0] sum;
    
    always @* begin
        sum = a + b;
        
        if (sum > 127 || sum < -128)
            overflow = 1;
        else
            overflow = 0;
    end
    
    assign s = sum;
    
endmodule
