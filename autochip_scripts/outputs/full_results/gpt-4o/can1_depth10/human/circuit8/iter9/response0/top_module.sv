module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock or negedge clock) begin
    if (clock == 1'b0) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= p;
        end
    end else if (clock == 1'b1) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
end

always @(negedge clock) begin
    q <= p;
end

endmodule
