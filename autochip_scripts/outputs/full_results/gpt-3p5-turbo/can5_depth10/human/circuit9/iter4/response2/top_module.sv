module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case (q)
        0: begin
            if (a == 1)
                q <= 4;
        end
        4: begin
            if (a == 1)
                q <= 6;
        end
        6: begin
            if (a == 1)
                q <= 0;
        end
        default: q <= 0;
    endcase
end

endmodule
