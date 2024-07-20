module top_module (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
    if (a == 1'b0) begin
        p_temp <= 1'b0;
        q_temp <= 1'b0;
    end else begin
        p_temp <= a;
        q_temp <= a;
    end
end

always @(posedge clock) begin
    p <= p_temp;
    q <= q_temp;
end

endmodule
