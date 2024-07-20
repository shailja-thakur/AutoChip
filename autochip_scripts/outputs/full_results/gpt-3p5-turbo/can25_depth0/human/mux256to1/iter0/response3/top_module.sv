module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] selected_input;

assign selected_input = (sel == 0) ? in[0] : 
                      (sel == 1) ? in[1] :
                      (sel == 2) ? in[2] :
                      ...
                      (sel == 255) ? in[255] : 0;

assign out = selected_input;

endmodule
