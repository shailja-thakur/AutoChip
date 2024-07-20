module flipflop (
    input clk,
    input r,
    input L,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= q;
    end
end

endmodule
module mux_2to1 (
    input s,
    input d0,
    input d1,
    output reg out
);

always @(s or d0 or d1) begin
    if (s) begin
        out <= d1;
    end else begin
        out <= d0;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire q1, q2, q3;
    wire s1, s2, s3;
    reg r1, r2, r3;
    wire d0, d1, d2;
    
    flipflop ff1 (.clk(clk), .r(r1), .L(L), .q(q1));
    flipflop ff2 (.clk(clk), .r(r2), .L(L), .q(q2));
    flipflop ff3 (.clk(clk), .r(r3), .L(L), .q(q3));
    
    mux_2to1 mux1 (.s(s1), .d0(q1), .d1(r_in), .out(d0));
    mux_2to1 mux2 (.s(s2), .d0(q2), .d1(q_in), .out(d1));
    mux_2to1 mux3 (.s(s3), .d0(q3), .d1(q_in), .out(d2));
    
    assign s1 = L;
    assign s2 = {q2[1] ^ q2[2], q2[0], q2[2]};
    assign s3 = {q3[1] ^ q3[2], q3[0], q3[2]};
    
    always @(posedge clk) begin
        r1 <= r_in;
        r2 <= d0;
        r3 <= d1;
        Q <= d2;
    end
    
endmodule
