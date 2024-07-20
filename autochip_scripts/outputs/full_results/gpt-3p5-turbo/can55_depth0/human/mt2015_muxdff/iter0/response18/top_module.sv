module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg q;

    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end
    
    submodule sub(
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r_in),
        .Q(Q)
    );
endmodule
module submodule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
