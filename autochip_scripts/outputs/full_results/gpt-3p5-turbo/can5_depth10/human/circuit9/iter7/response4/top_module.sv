module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 0) begin
        q <= 0;
    end else begin
        case (q)
            0: q <= 4;
            4: q <= 4;
            5: q <= 5;
            6: q <= 6; // Fixed: Assign q as 6 instead of 0
            default: q <= q;
        endcase
    end
end

endmodule
