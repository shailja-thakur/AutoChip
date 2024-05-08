module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    // Insert your code here

    assign pos = (in[3] & 1) | (in[2] & 2) | (in[1] & 4) | (in[0] & 8);

endmodule