module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [98:0] in_shifted;
    integer i;

    always @* begin
        // Calculate out_both
        for(i = 0; i < 99; i = i + 1) begin
            out_both[i] = (in[i] & in_shifted[i]);
        end

        // Calculate out_any
        for(i = 1; i < 100; i = i + 1) begin
            out_any[i] = (in[i] | in[i-1]);
        end

        out_any[0] = in[0]; // Set out_any[0] as in[0]

        // Calculate out_different
        for(i = 0; i < 100; i = i + 1) begin
            out_different[i] = (in[i] != in_shifted[i]);
        end
    end

    // Create in_shifted by shifting in to the left
    always @(in) begin
        in_shifted = {in[98:0], in[99]};
    end

endmodule
