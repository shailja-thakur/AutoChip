module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    reg [99:0] temp_and, temp_or, temp_xor;
    integer i;

    always @(*) begin
        temp_and = in[0];
        temp_or = in[0];
        temp_xor = in[0];
        for (i = 1; i < 100; i = i + 1) begin
            temp_and = temp_and & in[i];
            temp_or = temp_or | in[i];
            temp_xor = temp_xor ^ in[i];
        end
        out_and = temp_and;
        out_or = temp_or;
        out_xor = temp_xor;
    end

endmodule
