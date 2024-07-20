module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case (q)
        3'b000: if (a == 1'b1) q <= 4;
        3'b001: if (a == 1'b1) q <= 4;
        3'b010: if (a == 1'b1) q <= 4;
        3'b011: if (a == 1'b1) q <= 4;
        3'b100: if (a == 1'b1) q <= 5;
        3'b101: if (a == 1'b1) q <= 5;
        3'b110: if (a == 1'b1) q <= 6;
        3'b111: if (a == 1'b1) q <= 0;
        default: if (a == 1'b0) q <= q + 1;
    endcase
end

endmodule
