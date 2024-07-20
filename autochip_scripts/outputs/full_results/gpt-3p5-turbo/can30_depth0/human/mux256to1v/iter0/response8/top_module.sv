module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

    wire [255:0] out_sel;
    assign out_sel[0] = sel[0] ? in[7:4] : in[3:0];
    assign out_sel[1] = sel[1] ? in[15:12] : in[11:8];
    assign out_sel[2] = sel[2] ? in[23:20] : in[19:16];
    assign out_sel[3] = sel[3] ? in[31:28] : in[27:24];
    /* continue this pattern for all 256 4-bit inputs */

    assign out = out_sel[3:0];
    
endmodule
