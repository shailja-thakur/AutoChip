module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux21(
    input S,
    input I0,
    input I1,
    output reg O
);
    always @*
        if (S==1'b0)
            O <= I0;
        else
            O <= I1;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire [2:0] r;
    wire [2:0] q;

    flipflop ff1(
        .clk(clk),
        .D(r_in),
        .Q(q[0])
    );
    
    flipflop ff2(
        .clk(clk),
        .D(q_in),
        .Q(q[1])
    );
    
    mux21 mux(
        .S(L),
        .I0(q[0]),
        .I1(r),
        .O(q[2])
    );

    always @(posedge clk) begin
        if (L) begin
            r <= q_in;
        end else begin
            r <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    assign Q = q[2];

endmodule
