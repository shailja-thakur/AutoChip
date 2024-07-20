module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg flip_flop;

    assign state = flip_flop;

    always @(posedge clk) begin
        if (a == 0 && b == 0)
            flip_flop <= flip_flop; // hold state
        else if (a == 1 && b == 1)
            flip_flop <= ~flip_flop; // toggle state
        else
            flip_flop <= (b == 1) ? 1 : 0; // set to b
    end

    always @(posedge clk) begin
        if (a == 1 && b == 1)
            q <= ~flip_flop;
        else
            q <= flip_flop;
    end
endmodule
