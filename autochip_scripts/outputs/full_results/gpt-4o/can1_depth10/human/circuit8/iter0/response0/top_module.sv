module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock or negedge clock) begin
    if (clock == 1) begin
        if (a == 1) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end else begin
        if (a == 1) begin
            q <= 1;
        end else begin
            q <= p;
        end
    end
end

endmodule
