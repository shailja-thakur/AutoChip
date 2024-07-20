module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a == 0) begin
        p <= 0;
        q <= q;
    end
    else begin
        p <= p;
        q <= p;
    end
end

endmodule
