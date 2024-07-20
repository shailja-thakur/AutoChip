module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg flipflop;

    assign state = flipflop;

    // Sequentially trigger on the rising edge of the clock
    always @(posedge clk) begin
        // Logic to determine flipflop value based on a and b
        if (a == 1 && b == 1)
            flipflop <= !flipflop;
        else if (a == 1 && b == 0)
            flipflop <= flipflop;
        else if (a == 0 && b == 1)
            flipflop <= 1'b1;
        else if (a == 0 && b == 0)
            flipflop <= 1'b0;
    end

    // output q is the same as flipflop
    always @(*) begin
        q = flipflop;
    end

endmodule
