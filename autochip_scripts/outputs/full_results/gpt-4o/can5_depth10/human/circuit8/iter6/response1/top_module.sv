module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg state;

    always @(posedge clock) begin
        if (a)
            state <= 1;
        else
            state <= 0;
        p <= state;
    end

    always @(negedge clock) begin
        q <= p;
    end

endmodule
