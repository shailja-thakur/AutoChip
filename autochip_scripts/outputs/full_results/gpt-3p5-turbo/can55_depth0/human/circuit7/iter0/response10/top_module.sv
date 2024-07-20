module top_module (
    input clk,
    input a,
    output reg q
);

    always @(posedge clk) begin
        case (q)
            0: if (a == 0) begin
                    q <= 1;
                end
                else begin
                    q <= 0;
                end
            1: if (a == 0) begin
                    q <= 1;
                end
                else begin
                    q <= 1;
                end
        endcase
    end

endmodule
