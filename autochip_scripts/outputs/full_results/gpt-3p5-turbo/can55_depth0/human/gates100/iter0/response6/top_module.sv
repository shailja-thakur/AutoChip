module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in;
    assign out_or = |in;
    
    wire [99:0] xor_temp;
    assign xor_temp[0] = in[0];
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin : xor_loop
            xor_gate xor_inst (.in0(xor_temp[i-1]), .in1(in[i]), .out(xor_temp[i]));
        end
    endgenerate
    assign out_xor = xor_temp[99];
    
    // 100-input XOR gate
    module xor_gate (
        input in0,
        input in1,
        output out
    );
        assign out = in0 ^ in1;
    endmodule
