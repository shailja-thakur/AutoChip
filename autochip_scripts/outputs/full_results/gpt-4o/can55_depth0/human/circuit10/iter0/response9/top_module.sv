module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg flip_flop;

    always @(posedge clk) begin
        if (a == 1 && b == 1)
            flip_flop <= ~flip_flop;
        else if (a == 1 && b == 0)
            flip_flop <= 1'b0;
        else if (a == 0 && b == 1)
            flip_flop <= 1'b1;
    end

    assign q = flip_flop;
    assign state = flip_flop;

endmodule
