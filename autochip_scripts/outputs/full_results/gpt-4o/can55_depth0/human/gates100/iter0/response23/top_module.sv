module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

    integer i;

    always @(*) begin
        out_and = in[0];
        out_or = in[0];
        out_xor = in[0];
        for (i = 1; i < 100; i = i + 1) begin
            out_and = out_and & in[i];
            out_or = out_or | in[i];
            out_xor = out_xor ^ in[i];
        end
    end

endmodule
