module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case(q)
            0: q <= 4;
            4: q <= 5;
            5: q <= 6;
            default: q <= 0;
        endcase
    end else begin
        if (q != 0) begin
            q <= q - 1;
        end
    end
end

endmodule
