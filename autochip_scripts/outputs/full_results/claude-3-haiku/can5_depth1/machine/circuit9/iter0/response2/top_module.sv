module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        q <= 3'd4;
    end
    else begin
        case (q)
            3'd6: q <= 3'd0;
            default: q <= q + 1;
        endcase
    end
end

endmodule
