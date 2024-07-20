module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);
    reg a_prev;

    always @(negedge clock) begin
        q <= a;
    end

    always @(posedge clock or a) begin
        if (clock)
            p <= a;
    end
endmodule
