module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'b100: q <= 3'b101; // 4 => 5
            3'b101: q <= 3'b110; // 5 => 6
            3'b110: q <= 3'b000; // 6 => 0
            default: q <= q + 3'b001; // Increment q
        endcase
    end else begin
        q <= 3'b000; // Reset q to 0
    end
end

endmodule
