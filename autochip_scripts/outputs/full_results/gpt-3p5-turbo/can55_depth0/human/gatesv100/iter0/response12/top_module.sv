module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Intermediate wire to store the result for out_both
    wire [98:0] both_temp;
    // Intermediate wire to store the result for out_any
    wire [99:1] any_temp;
    // Intermediate wire to store the result for out_different
    wire [99:0] different_temp;
    
    // Logic for out_both
    assign both_temp[0] = in[0] & in[99];
    assign out_both = {both_temp, in[98:1] & in[97:0]};
    
    // Logic for out_any
    assign any_temp[99:1] = in[98:0] | in[99];
    assign out_any = any_temp;
    
    // Logic for out_different
    assign different_temp[99:1] = in[98:0] ^ in[99:1];
    assign different_temp[0] = in[0] ^ in[99];
    assign out_different = different_temp;

endmodule
