module top (
    input [3:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    out_and = 1'b1;
    out_or = 1'b0;
    out_xor = 1'b0;
    
    for (int i = 0; i < 4; i++) begin
        out_and = out_and & in[i];
        out_or = out_or | in[i];
        out_xor = out_xor ^ in[i];
    end
end

endmodule
