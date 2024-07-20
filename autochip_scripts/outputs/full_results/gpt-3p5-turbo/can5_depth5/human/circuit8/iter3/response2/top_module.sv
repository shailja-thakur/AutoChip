module top_module (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a == 0) begin
        p <= 0;
        q <= 0;
    end else begin
        p <= 1;
        q <= a;
    end
end

endmodule
