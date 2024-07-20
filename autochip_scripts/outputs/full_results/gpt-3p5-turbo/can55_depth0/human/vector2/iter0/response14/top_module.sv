module top_module (
	input [31:0] in,
	output [31:0] out
);

    reg [31:0] temp;

    always @ (in)
        temp =  {in[7:0], in[15:8], in[23:16], in[31:24]};

    assign out = temp;

endmodule
