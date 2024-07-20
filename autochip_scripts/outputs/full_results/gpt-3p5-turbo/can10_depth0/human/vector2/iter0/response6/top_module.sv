module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Instantiate the wires and registers
    wire [7:0] byte0, byte1, byte2, byte3;
    reg [31:0] reversed;

    // Split the 32-bit input into four bytes
    assign byte0 = in[7:0];
    assign byte1 = in[15:8];
    assign byte2 = in[23:16];
    assign byte3 = in[31:24];

    // Reverse the byte order
    always @(*) begin
        reversed = {byte3, byte2, byte1, byte0};
    end

    // Assign the reversed output
    assign out = reversed;

endmodule
