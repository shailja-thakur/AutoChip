module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock or negedge clock) begin
    if (clock == 1'b0) begin
        if (a == 1) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end else if (clock == 1'b1) begin
        if (a == 0) begin
            p <= 0;
        end else begin
            p <= 1;
        end
    end
end

always @(posedge clock or negedge clock) begin
    if (clock == 1'b0) begin
        if (a == 1) begin
            q <= 0;
        end else begin
            q <= 0;
        end
    end else if (clock == 1'b1) begin
        if (a == 0) begin
            q <= q;
        end else begin
            q <= 1;
        end
    end
end

endmodule
