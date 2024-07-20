module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Declare intermediate wire variables
    wire [98:0] both_wire;
    wire [99:1] any_wire;
    wire [99:0] different_wire;

    // Calculate out_both
    assign both_wire[98] = in[98] & in[99];
    assign both_wire[97:0] = in[97:0] & in[98:1];

    // Calculate out_any
    integer i;
    assign any_wire[2] = in[1] | in[0];
    for (i = 3; i <= 99; i=i+1) begin
        assign any_wire[i] = in[i-1] | in[i-2];
	end

    // Calculate out_different
    assign different_wire[0] = in[0] == in[98];
    assign different_wire[1:98] = in[1:98] != in[0:97];
    assign different_wire[99] = in[99] == in[97];

    // Assign outputs
    assign out_both = both_wire;
    assign out_any = any_wire;
    assign out_different = different_wire;
    
endmodule
