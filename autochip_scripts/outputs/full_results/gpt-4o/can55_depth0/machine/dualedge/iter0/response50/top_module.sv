module top_module(
    input clk,
    input d,
    output reg q
);

// Internal registers
reg qp, qn;

always @(posedge clk) begin
    qp <= d; // qp is updated with d on the positive edge of the clock
end

always @(negedge clk) begin
    qn <= d; // qn is updated with d on the negative edge of the clock
end

always @(posedge clk or negedge clk) begin
    if (clk)
        q <= qp; // If clk is positive, q is assigned the value of qp
    else
        q <= qn; // If clk is negative, q is assigned the value of qn
end

endmodule
