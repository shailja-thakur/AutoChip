module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg a_delayed;

    always @(posedge clock) begin
        p <= a;
        q <= a_delayed;
        a_delayed <= a;
    end
endmodule
