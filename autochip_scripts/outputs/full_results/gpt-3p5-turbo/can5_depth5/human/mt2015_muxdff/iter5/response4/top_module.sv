module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg [2:0] r;
    reg [2:0] q;

    flipflop U1(
        .clk(clk),
        .D(q_in),
        .Q(q[0])
    );

    flipflop U2(
        .clk(clk),
        .D(q[2]),
        .Q(q[1])
    );

    always @(posedge clk) begin
        if (L) begin
            q <= r_in; // Assign r_in directly to q when L is true
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
        r <= r_in; // Assign r_in to r regardless of L value
        Q <= q[2]; // Assign q[2] to Q instead of q[0]
    end

endmodule
module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module multiplexer(
    input A,
    input B,
    input S,
    output reg Z
);

    always @(A or B or S) begin
        if (S == 0)
            Z <= A;
        else
            Z <= B;
    end

endmodule
