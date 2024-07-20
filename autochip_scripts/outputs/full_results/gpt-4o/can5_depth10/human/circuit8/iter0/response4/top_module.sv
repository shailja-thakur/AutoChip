module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    reg last_a;

    always @(posedge clock) begin
        if (a && !last_a)
            p <= 1;
        else
            p <= 0;
    end

    always @(negedge clock) begin
        last_a <= a;
        if (last_a)
            q <= p;
        else
            q <= 0;
    end
endmodule
