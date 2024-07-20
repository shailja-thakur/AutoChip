module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    case (q)
        0:
            if (a == 0)
                q <= 1;
            else
                q <= 0;
        1:
            if (a == 0)
                q <= 1;
            else
                q <= 0;
    endcase
end

endmodule
