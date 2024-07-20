module top_module (
    input [31:0] in,
    output [31:0] out
);

// Declare intermediate wire variables
wire [7:0] in_byte0;
wire [7:0] in_byte1;
wire [7:0] in_byte2;
wire [7:0] in_byte3;
wire [7:0] out_byte0;
wire [7:0] out_byte1;
wire [7:0] out_byte2;
wire [7:0] out_byte3;

// Split the input into bytes
assign in_byte0 = in[7:0];
assign in_byte1 = in[15:8];
assign in_byte2 = in[23:16];
assign in_byte3 = in[31:24];

// Reverse the order of bytes
assign out_byte0 = in_byte3;
assign out_byte1 = in_byte2;
assign out_byte2 = in_byte1;
assign out_byte3 = in_byte0;

// Concatenate the reversed bytes to form the output
assign out = {out_byte3, out_byte2, out_byte1, out_byte0};

endmodule
