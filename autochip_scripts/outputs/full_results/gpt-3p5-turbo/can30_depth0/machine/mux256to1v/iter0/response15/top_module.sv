module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    reg [3:0] out_temp;
    
    always @(*) begin
        out_temp = in[sel*4 +: 4];
    end
    
    assign out = out_temp;
    
endmodule
