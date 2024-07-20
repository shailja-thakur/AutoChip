module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a == 1 && b == 1)
            state <= ~state;    // toggle state
        else if (a == 0 && b == 1)
            state <= q;         // state follows q
        else if (a == 1 && b == 0)
            q <= state;         // q follows state
        else
            q <= 0;             // reset q to 0 if both a and b are 0
    end

endmodule
