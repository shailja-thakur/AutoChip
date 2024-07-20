module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;         // 0 | 0 | Qold
            2'b01: Q <= 0;         // 0 | 1 | 0
            2'b10: Q <= 1;         // 1 | 0 | 1
            2'b11: Q <= ~Q;        // 1 | 1 | ~Qold
        endcase
    end

endmodule
