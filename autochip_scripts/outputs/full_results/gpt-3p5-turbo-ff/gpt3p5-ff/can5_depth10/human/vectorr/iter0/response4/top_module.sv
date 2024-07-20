module top_module (
    input [7:0] in,
    output [7:0] out
);

    reg [7:0] reversed;

    assign out = reversed;

    always @(in) begin
        reversed[7] = in[0];
        reversed[6] = in[1];
        reversed[5] = in[2];
        reversed[4] = in[3];
        reversed[3] = in[4];
        reversed[2] = in[5];
        reversed[1] = in[6];
        reversed[0] = in[7];
    end

endmodule
