module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg pre_q;

    always @(posedge clock) begin
        pre_q <= a;
        p <= pre_q;
    end

    always @(negedge clock) begin
        q <= p;
    end
endmodule
