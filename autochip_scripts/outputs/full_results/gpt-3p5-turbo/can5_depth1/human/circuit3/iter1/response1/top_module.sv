module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    reg q_reg;

    always @(*) begin
        q_reg = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & d) | (a & ~b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);
    end
    
    assign q = q_reg;

endmodule
