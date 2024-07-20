module top_module (
    input clk,
    input a, 
    output reg q
);

    // This circuit's behavior is such that q switches to 1 on the rising edge of clk
    // when a is 0. When a is 1, q will switch to 0 on the next rising edge of clk.
    always @(posedge clk) begin
        if (a == 0)
            q <= 1;
        else
            q <= 0;
    end

endmodule
