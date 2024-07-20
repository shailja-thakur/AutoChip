module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg q_delay1;
reg q_delay2;

always @(posedge clock) begin
    q_delay2 <= q_delay1;
    q_delay1 <= q;
end

always @(posedge clock) begin
    if (a) begin
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        p <= q_delay2;
        q <= p;
    end
end

endmodule
