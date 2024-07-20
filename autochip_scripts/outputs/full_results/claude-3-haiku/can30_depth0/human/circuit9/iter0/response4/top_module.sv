module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'b000: q <= 3'b100; // 4
            3'b100: q <= 3'b100; // 4
            3'b101: q <= 3'b110; // 6
            3'b110: q <= 3'b000; // 0
            default: q <= 3'b001; // 1
        endcase
    end
    else begin
        q <= q;
    end
end

endmodule
