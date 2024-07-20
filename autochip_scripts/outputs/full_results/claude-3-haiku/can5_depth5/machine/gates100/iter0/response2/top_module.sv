module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Initialize the output variables
    assign out_and = 1'b1;
    assign out_or = 1'b0;
    assign out_xor = 1'b0;

    // Perform the logical operations
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin
            assign out_and = out_and & in[i];
            assign out_or = out_or | in[i];
            assign out_xor = out_xor ^ in[i];
        end
    endgenerate

endmodule
