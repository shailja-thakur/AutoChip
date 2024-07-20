module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    case ({a, q})
        4'b1000: q <= 3'b100;
        4'b1100: q <= q;
        4'b1101: q <= 3'b110;
        4'b1110: q <= 3'b000;
        4'b0100: q <= 3'b101;
        4'b0101: q <= 3'b110;
        4'b0110: q <= 3'b000;
        4'b0000: q <= 3'b001;
        4'b0001: q <= q;
        default: q <= 3'b000;
    endcase
end

endmodule
