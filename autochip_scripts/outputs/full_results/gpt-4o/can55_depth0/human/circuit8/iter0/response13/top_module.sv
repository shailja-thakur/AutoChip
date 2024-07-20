module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    always @(posedge clock) begin
        p <= a;
        if (a)
            q <= 0;
        else
            q <= p;
    end

    always @(negedge clock) begin
        if (!a)
            q <= p;
    end
endmodule
