module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

    reg [3:0] out;
    reg [3:0] selected_block;

    always @(sel) begin
        selected_block = in[sel*4 +: 4];
    end

    assign out = selected_block;

endmodule
