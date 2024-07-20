module top (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;             // No change
        2'b01: Q <= 1'b0;          // Reset Q
        2'b10: Q <= 1'b1;          // Set Q
        2'b11: Q <= ~Q;            // Toggle Q
    endcase
end

endmodule
