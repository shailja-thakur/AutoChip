module top_module (
    input [2:0] a,
    output reg [15:0] q
);

    always @* begin
        case(a)
            3'b000: q = 16'b0000000001001100;    // Time = 15ns
            3'b001: q = 16'b0000101011100000;    // Time = 20ns, 60ns, 75ns, 80ns
            3'b010: q = 16'b0010011111010100;    // Time = 25ns, 65ns
            3'b011: q = 16'b0101101000001110;    // Time = 30ns, 85ns
            3'b100: q = 16'b0010000001100110;    // Time = 35ns
            3'b101: q = 16'b0110010011001110;    // Time = 40ns, 90ns
            3'b110: q = 16'b1100100100010110;    // Time = 45ns
            3'b111: q = 16'b0010011110101101;    // Time = 50ns
            default: q = 16'bxxxxxxxxxxxxxxxx;    // Time = 0ns, 5ns, 10ns
        endcase
    end

endmodule
