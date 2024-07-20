module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        case (q)
            4: q <= 0;
            5: q <= 4;
            6: q <= 5;
            default: q <= 6;
        endcase
    end
end

endmodule
