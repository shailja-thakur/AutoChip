module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
    if (a == 1) begin
        p_temp <= 1;
        q_temp <= 1;
    end else begin
        p_temp <= 0;
        q_temp <= 0;
    end
end

always @(posedge clock) begin
    if (p_temp == 1 && q_temp == 0) begin
        p <= 0;
        q <= 0;
    end else if (p_temp == 1 && q_temp == 1) begin
        p <= 1;
        q <= 1;
    end else if (p_temp == 0 && q_temp == 1) begin
        p <= 1;
        q <= 1;
    end else begin
        p <= 0;
        q <= 0;
    end
end

endmodule
