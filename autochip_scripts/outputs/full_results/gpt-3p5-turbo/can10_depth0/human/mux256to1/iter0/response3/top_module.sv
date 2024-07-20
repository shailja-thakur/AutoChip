module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

    wire [255:0] selected_in;
    
    assign selected_in = in[sel*32 +: 32];
    
    assign out = selected_in | 256'h0;
                       
endmodule
