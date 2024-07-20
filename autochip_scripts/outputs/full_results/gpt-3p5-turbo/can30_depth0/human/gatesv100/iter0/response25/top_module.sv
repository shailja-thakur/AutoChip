module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [99:0] in_shifted; // Shifted version of input

    always @(*) begin
        out_different = in ^ {in[99], in[99:1]}; // XOR of input with shifted input

        out_both[0] = 0; // No left neighbor for in[0]
        for (int i = 1; i < 99; i=i+1) begin
            out_both[i] = in[i] & in_shifted[i];
        end

        for (int i = 0; i < 99; i=i+1) begin
            out_any[i] = in[i] | in_shifted[i];
        end
        out_any[99] = 0; // No right neighbor for in[99]
    end

    always @(posedge clk) begin
        in_shifted <= in << 1; // Left shift input by 1
    end
endmodule
