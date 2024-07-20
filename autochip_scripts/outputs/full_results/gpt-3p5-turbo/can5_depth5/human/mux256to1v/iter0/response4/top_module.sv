module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_select;
assign in_select = {in[8*sel+3 : 8*sel]};

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : mux_instance
        assign out = in_select[i] ? in_select[i] : 0;
    end
endgenerate

endmodule
