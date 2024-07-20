module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

    reg [7:0] index;
    wire selected_bit;
    
    always @(*) begin
        index = sel;
        selected_bit = in[index];
    end
    
    assign out = selected_bit;

endmodule
