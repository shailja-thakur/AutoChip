module top_module (
    input [2:0] in,
    output reg [1:0] out
);

    always @(*) begin
        out[0] = in[0] + in[1] + in[2]; // sum of all bits in the input vector
        out[1] = out[0] != 3'b000 ? 1'b1 : 1'b0; // output 1 if sum is not zero, else output 0
    end

endmodule
