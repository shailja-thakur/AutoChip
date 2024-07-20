module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg r_p;
reg r_q;

always @(posedge clock) begin
    if (a) begin
        r_p <= 1;
        r_q <= 0;
    end else begin
        if (r_p && !r_q)
            r_q <= 1;
        else
            r_q <= 0;
        r_p <= 0;
    end
end

assign p = r_p;
assign q = r_q;

endmodule
