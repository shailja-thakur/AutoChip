module top_module (
    input clock,
    input wire a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a) begin
        p <= 0;
        q <= 0;
    end else if (p) begin
        q <= 1;
    end else begin
        q <= 0;
    end
end

endmodule
