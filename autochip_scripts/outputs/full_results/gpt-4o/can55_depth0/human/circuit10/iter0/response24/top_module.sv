module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a && b)
            q <= ~q; // Toggle q if both a and b are 1
        else if (!a && b)
            q <= 1; // Set q to 1 if a is 0 and b is 1
        else if (a && !b)
            q <= 0; // Set q to 0 if a is 1 and b is 0
        // if a is 0 and b is 0, q remains unchanged

        // state is just a copy of q
        state <= q;
    end

endmodule
