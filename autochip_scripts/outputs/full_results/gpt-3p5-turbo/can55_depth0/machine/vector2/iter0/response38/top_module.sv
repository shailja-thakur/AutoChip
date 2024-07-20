module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [7:0] chunk [3:0];

    assign out[31:24] = chunk[3];
    assign out[23:16] = chunk[2];
    assign out[15:8] = chunk[1];
    assign out[7:0] = chunk[0];

    always @(*) begin
        chunk[0] = in[7:0];
        chunk[1] = in[15:8];
        chunk[2] = in[23:16];
        chunk[3] = in[31:24];
    end

endmodule
