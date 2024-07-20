module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez(in)
        4'b1???: pos = 2'b11; // 1xxx
        4'b01??: pos = 2'b10; // 01xx
        4'b001?: pos = 2'b01; // 001x
        4'b0001: pos = 2'b00; // 0001
        default: pos = 2'b00; // all other cases
    endcase
end

endmodule
