module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    reg [8:0] sum;
    reg [7:0] a_signed;
    reg [7:0] b_signed;
    
    always @(*) begin
        // Sign-extend a and b
        a_signed = (a[7] == 1) ? {{8{1'b1}}, a[7:0]} : {{8{1'b0}}, a[7:0]};
        b_signed = (b[7] == 1) ? {{8{1'b1}}, b[7:0]} : {{8{1'b0}}, b[7:0]};
    
        // Perform addition
        sum = a_signed + b_signed;
        
        // Assign result to s
        s = sum[7:0];
        
        // Check for overflow
        if (sum[8] != sum[7]) begin
            overflow = 1'b1;
        end else begin
            overflow = 1'b0;
        end
    end
endmodule
