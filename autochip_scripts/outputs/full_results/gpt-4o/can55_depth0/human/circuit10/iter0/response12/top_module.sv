module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @ (posedge clk) begin
        if (a & b)
            state <= ~state;
        else
            state <= state;

        q <= state;
    end

endmodule
