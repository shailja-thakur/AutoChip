module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;      // Qold
        2'b01: Q <= 1'b0;   // K = 1
        2'b10: Q <= 1'b1;   // J = 1
        2'b11: Q <= ~Q;     // J = 1, K = 1
    endcase
end

endmodule
