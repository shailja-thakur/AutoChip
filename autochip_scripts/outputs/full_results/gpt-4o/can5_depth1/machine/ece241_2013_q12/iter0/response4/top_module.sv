module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    reg [7:0] q;  // 8-bit register

    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S};  // Shift the register and input S
        end
    end

    // 3-bit address is formed by combining A, B, and C
    wire [2:0] addr = {C, B, A};

    // Multiplex the output based on the 3-bit address
    always @(*) begin
        case (addr)
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b010: Z = q[2];
            3'b011: Z = q[3];
            3'b100: Z = q[4];
            3'b101: Z = q[5];
            3'b110: Z = q[6];
            3'b111: Z = q[7];
            default: Z = 1'b0;  // Default case
        endcase
    end

endmodule
