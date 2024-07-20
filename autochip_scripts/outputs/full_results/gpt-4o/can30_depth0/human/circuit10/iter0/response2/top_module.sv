module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update the state based on inputs a and b
        if (a && b)
            state <= 1;
        else
            state <= 0;

        // The output q is the same as the state
        q <= state;
    end
endmodule
