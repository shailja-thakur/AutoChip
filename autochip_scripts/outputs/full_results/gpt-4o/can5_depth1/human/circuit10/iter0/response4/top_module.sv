module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a == 1 && b == 1)
            state <= ~state;
        else if (a == 0 && b == 1)
            state <= 1;
        else if (a == 1 && b == 0)
            state <= 0;

        q <= state;
    end

endmodule
