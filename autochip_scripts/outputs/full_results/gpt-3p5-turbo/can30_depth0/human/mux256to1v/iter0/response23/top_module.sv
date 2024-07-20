module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [255:0] in_sel;

// Splitting input into individual 4-bit sections
generate
    for (i = 0; i < 256; i=i+1) begin: split_input
        assign in_sel[i] = in[i*4+3:i*4];
    end
endgenerate

// Selecting the appropriate input based on the 'sel' value
assign out = in_sel[sel];

endmodule
