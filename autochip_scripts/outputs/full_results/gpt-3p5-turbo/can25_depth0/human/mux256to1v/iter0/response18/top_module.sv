module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
	
    wire [255:0] in_slice [7:0];
    wire [3:0] out_slice [7:0];
	
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin : slice_gen
            assign in_slice[i] = in[128*i +: 128];
            assign out_slice[i] = in_slice[i][4*sel +: 4];
        end
    endgenerate
	
    assign out = out_slice[sel];
	
endmodule
