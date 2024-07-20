module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire [2:0] r;
    wire [2:0] q;

    full_module full1(
        .clk(clk),
        .L(L),
        .r(r_in),
        .q(q[0])
    );

    full_module full2(
        .clk(clk),
        .L(L),
        .r(r),
        .q(q[1])
    );

    full_module full3(
        .clk(clk),
        .L(L),
        .r(r),
        .q(q[2])
    );

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= {q[1] ^ q[2], q_in, q[2]};
        end
    end
    
endmodule
