module flipflop (
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux (
    input [1:0] S,
    input D0,
    input D1,
    output reg Y
);
    always @(*)
    begin
        case (S)
            2'b00: Y = D0;
            2'b01: Y = D1;
            2'b10: Y = D0;
            2'b11: Y = D1;
            default: Y = 1'b0;
        endcase
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg [2:0] r;
    reg [2:0] q_out;
    wire d0, d1;

    assign d0 = q_out[1] ^ q_out[2];
    assign d1 = q_out[0] | q_out[2];

    flipflop ff_inst1 (
        .clk(clk),
        .D(r_in),
        .Q(q_out[0])
    );

    flipflop ff_inst2 (
        .clk(clk),
        .D(q_out[1]),
        .Q(q_out[1])
    );

    mux mux_inst (
        .S({q_in, L}),
        .D0(q_out[2]),
        .D1(r_in),
        .Y(q_out[2])
    );

    always @(posedge clk)
    begin
        if (L) begin
            r <= r_in;
        end else begin
            r <= {d0, d1, r[2]};
        end
    end

    assign Q = q_out[2];

endmodule
