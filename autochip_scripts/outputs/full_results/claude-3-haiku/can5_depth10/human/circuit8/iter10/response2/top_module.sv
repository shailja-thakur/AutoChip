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
    if (p == 1'b1 && a == 1'b0) begin
        q <= 1'b1;
    end else if (a == 1'b1) begin
        q <= 1'b0;
    end else begin
        q <= q;
    end
end

endmodule
