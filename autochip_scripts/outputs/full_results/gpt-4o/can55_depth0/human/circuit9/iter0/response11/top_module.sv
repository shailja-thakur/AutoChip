module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'd4;
        end else begin
            q <= q + 3'd1;
            if (q == 3'd7) begin
                q <= 3'd0;
            end
        end
    end

endmodule
