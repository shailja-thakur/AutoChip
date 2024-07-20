module top_module (
	input [7:0] in,
	output [31:0] out
);
    
    wire [31:0] sign_ext;
    
    assign sign_ext = {24{in[7]}, in};
    
    assign out = sign_ext;
    
endmodule
