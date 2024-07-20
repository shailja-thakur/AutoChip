module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);
    
    always @(*) begin
        if (do_sub)
            out = a - b;
        else
            out = a + b;
        
        // Check if the result is zero
        if (out == 8'b0)
            result_is_zero = 1'b1;
        else
            result_is_zero = 1'b0;
    end
    
endmodule
