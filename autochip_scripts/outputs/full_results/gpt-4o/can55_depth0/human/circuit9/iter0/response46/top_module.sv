module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 4;
        end else begin
            q <= (q == 6) ? 0 : (q + 1);
        end
    end

endmodule
