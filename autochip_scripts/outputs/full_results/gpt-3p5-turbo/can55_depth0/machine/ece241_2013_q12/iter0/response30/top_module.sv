module top_module (
    input clk,
    input enable,
    input S,
    input [2:0] A,    // Updated to a 3-bit input
    input [2:0] B,    // Updated to a 3-bit input
    input [2:0] C,    // Updated to a 3-bit input
    output reg Z
);

reg [7:0] q;   // Changed from 8-bit to 8-bit register

always @(posedge clk) begin
    if (enable) begin
        q <= {q[6:0], S};   // Shifting input S into the register
    end
end

always @(*) begin
    case({A, B, C})   // Combining A, B, and C to form a 3-bit address
        3'b000: Z <= q[0];
        3'b001: Z <= q[1];
        3'b010: Z <= q[2];
        3'b011: Z <= q[3];
        3'b100: Z <= q[4];
        3'b101: Z <= q[5];
        3'b110: Z <= q[6];
        3'b111: Z <= q[7];
    endcase
end

endmodule
