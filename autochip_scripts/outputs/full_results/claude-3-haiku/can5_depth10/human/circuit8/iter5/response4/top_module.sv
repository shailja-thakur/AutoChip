module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    // Update p
    p <= a;

    // Update q
    if (p == 1) begin
        q <= 0;
    end else begin
        q <= q;
    end
end

endmodule
