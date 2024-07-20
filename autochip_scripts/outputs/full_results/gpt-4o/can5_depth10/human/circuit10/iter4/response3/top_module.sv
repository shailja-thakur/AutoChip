module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= a;  // Capture `a` in the flip-flop on rising edge of clk
    end

    always @(posedge clk) begin
        if (b)
            q <= ~state;
        else
            q <= state;
    end

endmodule
