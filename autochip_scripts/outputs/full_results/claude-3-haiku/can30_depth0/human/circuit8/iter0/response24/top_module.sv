module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a == 0 && p == 0) begin
        q <= 0;
    end else if (a == 1 && p == 0) begin
        q <= 0;
    end else if (a == 0 && p == 1) begin
        q <= 1;
    end else if (a == 1 && p == 1) begin
        q <= 1;
    end
end

always @(posedge clock) begin
    if (a == 0 && q == 0) begin
        p <= 0;
    end else if (a == 1 && q == 0) begin
        p <= 1;
    end else if (a == 0 && q == 1) begin
        p <= 1;
    end else if (a == 1 && q == 1) begin
        p <= 0;
    end
end

endmodule
