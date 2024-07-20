module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    
    always @(*) begin
        // Add the two numbers
        sum = a + b;
        
        // Check for overflow
        if (sum[8] == 1) begin
            overflow = 1;
        end
        else begin
            overflow = 0;
        end
        
        // Assign the result
        s = sum[7:0];
    end
    
endmodule
