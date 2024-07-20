module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    // Update p
    if (a) begin
        p <= 1;
    end else begin
        p <= 0;
    end

    // Update q
    if (p) begin
        q <= 0;
    end else begin
        q <= a;
    end
end

endmodule
