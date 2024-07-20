module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg c;
    reg q;
    
    always @(posedge clk) begin
        c <= a & b | a & c | b & c;
        q <= a ^ b ^ c;
        state <= c;
    end

endmodule
