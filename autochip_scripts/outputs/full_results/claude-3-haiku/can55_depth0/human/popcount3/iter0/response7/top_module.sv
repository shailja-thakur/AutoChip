module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [2:0] count;

// Assign the number of '1's in the input vector to the 'count' wire
assign count[0] = in[0] ^ in[1] ^ in[2];
assign count[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]);
assign count[2] = (in[0] & in[1] & in[2]);

// Assign the 'out' output based on the 'count' wire value
assign out[0] = count[0];
assign out[1] = count[1];

endmodule
