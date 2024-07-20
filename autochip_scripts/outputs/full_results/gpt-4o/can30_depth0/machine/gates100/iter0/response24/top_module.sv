module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    // Intermediate wires to hold results of AND, OR, and XOR operations
    wire [99:0] and_result;
    wire [99:0] or_result;
    wire [99:0] xor_result;

    // Generate AND result
    assign and_result[0] = in[0];
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_and
            assign and_result[i] = and_result[i-1] & in[i];
        end
    endgenerate
    assign out_and = and_result[99];

    // Generate OR result
    assign or_result[0] = in[0];
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_or
            assign or_result[i] = or_result[i-1] | in[i];
        end
    endgenerate
    assign out_or = or_result[99];

    // Generate XOR result
    assign xor_result[0] = in[0];
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_xor
            assign xor_result[i] = xor_result[i-1] ^ in[i];
        end
    endgenerate
    assign out_xor = xor_result[99];

endmodule
