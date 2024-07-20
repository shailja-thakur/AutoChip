module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [1:0] state;

always @(posedge clock) begin
    state <= {p, q};
    case (state)
        2'b00: p <= a;
        2'b01: p <= a;
        2'b10: p <= 1'b1;   // stay 1 when p was 1
        2'b11: p <= 1'b1;   // stay 1 when p was 1
    endcase
end

always @(negedge clock) begin
    state <= {p, q};
    case (state)
        2'b00: q <= p;
        2'b01: q <= p;
        2'b10: q <= 1'b1;   // stay 1 when q was 1
        2'b11: q <= 1'b1;   // stay 1 when q was 1
    endcase
end

endmodule
