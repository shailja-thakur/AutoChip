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
            6: q <= 0; // Instead of assigning 6, assign 0 when q is 6
            default: q <= q;
        endcase
    end
end

endmodule
