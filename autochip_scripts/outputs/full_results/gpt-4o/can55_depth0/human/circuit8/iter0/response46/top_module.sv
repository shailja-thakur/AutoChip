module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    // When clock rises, p should follow the value of a
    p <= a;
end

always @(negedge clock) begin
    // When clock falls, q should follow the value of p
    q <= p;
end

endmodule
