module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    wire [99:0] and_inputs;
  
    assign out_and = & and_inputs;
    assign out_or = | in;
    assign out_xor = ^ in;

    assign and_inputs = in;
endmodule
