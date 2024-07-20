module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;            // 0 | 0 | Qold
        2'b01: Q <= 1'b0;         // 0 | 1 | 0
        2'b10: Q <= 1'b1;         // 1 | 0 | 1
        2'b11: Q <= ~Q;           // 1 | 1 | ~Qold
        default: Q <= Q;
    endcase
end

endmodule
