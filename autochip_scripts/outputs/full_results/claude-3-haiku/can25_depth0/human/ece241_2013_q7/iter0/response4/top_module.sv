module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;        // Qold
        2'b01: Q <= 1'b0;      // 0
        2'b10: Q <= 1'b1;      // 1
        2'b11: Q <= ~Q;        // ~Qold
    endcase
end

endmodule
