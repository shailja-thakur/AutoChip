module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Declare intermediate wire variables
    reg [98:0] both_wire;
    reg [99:1] any_wire;
    reg [99:0] different_wire;

    // Calculate out_both
    always @(in) begin
        both_wire[98] = in[98] & in[99];
        both_wire[97:0] = in[97:0] & in[98:1];
    end

    // Calculate out_any
    always @(in) begin
        any_wire[99:2] = in[99:2] | in[98:1];
        any_wire[1] = in[0];
        any_wire[0] = 0;
    end

    // Calculate out_different
    always @(in) begin
        different_wire[0] = in[0] != in[98];
        different_wire[98:1] = in[98:1] != in[97:0];
        different_wire[99] = in[99] != in[97];
    end

    // Assign outputs
    assign out_both = both_wire;
    assign out_any = any_wire[99:1];
    assign out_different = different_wire;
    
endmodule
