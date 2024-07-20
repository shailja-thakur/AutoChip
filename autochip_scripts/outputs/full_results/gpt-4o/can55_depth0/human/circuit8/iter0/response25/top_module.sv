module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock or posedge a) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (p == 1) begin
            q <= 0;
        end else begin
            q <= 1;
        end
    end

endmodule
