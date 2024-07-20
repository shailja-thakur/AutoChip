module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg curr_p;
reg curr_q;

always @(posedge clock) begin
    curr_p <= a & ~curr_q;
    curr_q <= ~curr_p;
end

assign p = curr_p;
assign q = curr_q;

endmodule
