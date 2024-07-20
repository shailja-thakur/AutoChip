module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    
    always @(*) begin
        case ({a, b, c, d})
            
            // when a=0, b=0, c=0, d=0, q=0
            4'b0000: q = 1'b0;
            
            // when a=0, b=0, c=0, d=1, q=0
            4'b0001: q = 1'b0;
            
            // when a=0, b=0, c=1, d=0, q=0
            4'b0010: q = 1'b0;
            
            // when a=0, b=0, c=1, d=1, q=0
            4'b0011: q = 1'b0;
            
            // when a=0, b=1, c=0, d=0, q=0
            4'b0100: q = 1'b0;
            
            // when a=0, b=1, c=0, d=1, q=1
            4'b0101: q = 1'b1;
            
            // when a=0, b=1, c=1, d=0, q=1
            4'b0110: q = 1'b1;
            
            // when a=0, b=1, c=1, d=1, q=1
            4'b0111: q = 1'b1;
            
            // when a=1, b=0, c=0, d=0, q=0
            4'b1000: q = 1'b0;
            
            // when a=1, b=0, c=0, d=1, q=1
            4'b1001: q = 1'b1;
            
            // when a=1, b=0, c=1, d=0, q=1
            4'b1010: q = 1'b1;
            
            // when a=1, b=0, c=1, d=1, q=1
            4'b1011: q = 1'b1;
            
            // when a=1, b=1, c=0, d=0, q=0
            4'b1100: q = 1'b0;
            
            // when a=1, b=1, c=0, d=1, q=1
            4'b1101: q = 1'b1;
            
            // when a=1, b=1, c=1, d=0, q=1
            4'b1110: q = 1'b1;
            
            // when a=1, b=1, c=1, d=1, q=1
            4'b1111: q = 1'b1;
            
        endcase
    end
    
endmodule
