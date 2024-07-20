module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        case (q)
            4: q <= 5;
            5: q <= 6;
            6: q <= 0;
            0: q <= 1;
            default: q <= 0;
        endcase
    end else begin
        q <= 1;
    end
end

endmodule
