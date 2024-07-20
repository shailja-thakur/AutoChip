module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 4;
        end else begin
            if (q == 6)
                q <= 0;
            else
                q <= q + 1;
        end
    end

endmodule
