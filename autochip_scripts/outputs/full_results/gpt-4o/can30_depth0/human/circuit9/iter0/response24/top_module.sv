module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1)
            q <= 3'd4;
        else
            q <= (q + 3'd1) % 3'd7;
    end

endmodule
