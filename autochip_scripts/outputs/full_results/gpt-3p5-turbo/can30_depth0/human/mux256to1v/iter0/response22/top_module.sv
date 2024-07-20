module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_vec;              // Create 256-bit wire vector
assign in_vec[0] = in[3:0];       // Assign first 4 bits of input to in_vec[0]
assign in_vec[1] = in[7:4];       // Assign next 4 bits of input to in_vec[1]
...
assign in_vec[254] = in[1023:1020]; // Assign last 4 bits of input to in_vec[254]
assign in_vec[255] = in[1027:1024]; // Assign last 4 bits of input to in_vec[255]

wire [3:0] out_reg;               // Create 4-bit output register
assign out = out_reg;             // Assign output register to out

always @(sel) begin              // Start always block
	case (sel)                    // Start case statement based on sel value
		0: out_reg = in_vec[0];        // If sel is 0, assign in_vec[0] to out_reg
		1: out_reg = in_vec[1];        // If sel is 1, assign in_vec[1] to out_reg
		2: out_reg = in_vec[2];        // If sel is 2, assign in_vec[2] to out_reg
		...                          // Continue assigning in_vec values to out_reg based on sel value
		255: out_reg = in_vec[255];    // If sel is 255, assign in_vec[255] to out_reg
	endcase                      // End case statement
end                            // End always block

endmodule
