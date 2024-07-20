module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(negedge clock) begin
    q <= a;
end

always @(posedge clock) begin
    if (a) begin
        p <= a;
    end
    else begin
        p <= p;
    end
end

endmodule
