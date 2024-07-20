module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock)
    begin
        p <= a;
        if (a == 1) 
            q <= 0;
    end

    always @(negedge clock)
    begin
        q <= p;
    end

endmodule
