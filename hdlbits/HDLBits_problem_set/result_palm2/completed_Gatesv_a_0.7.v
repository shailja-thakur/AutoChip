module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    always @(posedge clk) begin
        out_both = '0';
        out_any = '0';
        out_different = '0';

        for (int i = 0; i < 3; i++) begin
            if (in[i] == in[i+1]) begin
                out_both[i/2] = '1';
            end

            if (in[i] || in[i+1]) begin
                out_any[i/2] = '1';
            end

            if (in[i] != in[i+1]) begin
                out_different[i/2] = '1';
            end
        end
    end

endmodule