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
            4: q <= 5;
            default: q <= 0;
        endcase
    end
end

endmodule
