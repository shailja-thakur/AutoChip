module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            3'd4: q <= 3'd5;
            3'd5: q <= 3'd6;
            3'd6: q <= 3'd0;
            default: q <= q + 1;
        endcase
    end
    else begin
        q <= q;
    end
end

endmodule
