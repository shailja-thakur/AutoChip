module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg q_temp;

always @(posedge clock) begin
    if (a == 1'b1) begin
        p <= 1'b1;
        q_temp <= 1'b0;
    end else if (q_temp == 1'b1) begin
        p <= 1'b0;
        q_temp <= 1'b1;
    end else if (p == 1'b0) begin
        p <= 1'b0;
        q_temp <= 1'b0;
    end else begin
        p <= 1'b1;
        q_temp <= 1'b1;
    end
end

assign q = q_temp;

endmodule
