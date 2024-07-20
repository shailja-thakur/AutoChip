module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Logic for out_both
    assign out_both[0] = in[0] & in[99];
    always @ (in) begin
        for (int i = 1; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i-1];
        end
    end

    // Logic for out_any
    assign out_any[99] = in[98] | in[99];
    always @ (in) begin
        for (int i = 1; i < 99; i = i + 1) begin
            out_any[i] = in[i] | in[i+1];
        end
    end

    // Logic for out_different
    assign out_different[0] = (in[0] != in[99]);
    always @ (in) begin
        for (int i = 1; i < 100; i = i + 1) begin
            out_different[i] = (in[i] != in[i-1]);
        end
    end

endmodule
