module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'b100: q <= 3'b100; // Maintain value of 4
            3'b101: q <= 3'b110; // Increment to 6
            3'b110: q <= 3'b000; // Reset to 0
            default: q <= q + 1; // Increment otherwise
        endcase
    end else begin
        q <= q;
    end
end

endmodule
