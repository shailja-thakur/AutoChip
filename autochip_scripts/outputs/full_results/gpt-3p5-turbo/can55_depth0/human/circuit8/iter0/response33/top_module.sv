module top_module (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a == 1'b0) begin
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        p <= 1'b1;
    end
    
    if (p == 1'b1) begin
        q <= 1'b0;
    end else begin
        if (q == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= 1'b1;
        end
    end
end

endmodule
