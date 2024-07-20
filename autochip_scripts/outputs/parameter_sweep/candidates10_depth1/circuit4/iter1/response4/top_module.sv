module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

    always @* begin
        if (~a & ~b & ~c & d) | (~a & ~b & c) | (~a & b & ~c) | (~a & b & c & ~d) | (a & b & ~c) | (a & b & c) begin
            q = 1;
        end else begin
            q = 0;
        end
    end
    
endmodule
