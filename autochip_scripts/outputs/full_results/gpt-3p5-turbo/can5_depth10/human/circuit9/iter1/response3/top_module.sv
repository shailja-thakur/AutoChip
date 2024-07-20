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
            0: q <= 1;
            1: q <= 4;
            2: q <= 4;
            3: q <= 4;
            4: q <= 5;
            5: q <= 6;
            default: q <= 0;
        endcase
    end
end

endmodule
