module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Updating flip-flop state
        if (a == 1 && b == 1)
            state <= ~state;
        else if (a == 1 && b == 0)
            state <= 0;
        else
            state <= state;
    end

    always @(posedge clk) begin
        // Updating output q
        if (a == 1 && b == 0)
            q <= 0;
        else if (a == 1 && b == 1)
            q <= ~q;
        else if (a == 0 && b == 1)
            q <= 1;
        else
            q <= q;
    end

endmodule
