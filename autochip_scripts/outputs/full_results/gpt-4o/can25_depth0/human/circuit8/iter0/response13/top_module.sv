module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        if (a)
            p <= 1;
        else
            p <= 0;
    end

    always @(negedge clock) begin
        if (p)
            q <= 1;
        else
            q <= 0;
    end

endmodule
