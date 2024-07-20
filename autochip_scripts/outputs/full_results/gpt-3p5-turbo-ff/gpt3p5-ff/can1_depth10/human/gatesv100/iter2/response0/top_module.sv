module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    
    // Declare intermediate wire variables
    wire [98:0] both_wire;
    wire [99:2] any_wire;
    wire [99:0] different_wire;
    
    // Calculate out_both
    assign both_wire[98] = in[98] & in[99];
    assign both_wire[97:0] = in[97:0] & in[98:1];
    
    // Calculate out_any
    assign any_wire[99:2] = in[98:1] | in[99:2];
    assign any_wire[1] = in[0];
    
    // Calculate out_different
    assign different_wire[98] = in[98] != in[99];
    assign different_wire[97:0] = in[97:0] != in[98:1];
    assign different_wire[99] = in[99] != in[98];
    
    // Assign outputs
    assign out_both = both_wire;
    assign out_any = any_wire;
    assign out_different = different_wire;
    
endmodule
