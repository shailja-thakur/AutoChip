module flipflop(
    input clk,
    input D,
    output reg Q
);
 
    always @(posedge clk) begin
        Q <= D;
    end
 
endmodule
module mux_2_1(
    input S,
    input I0,
    input I1,
    output reg O
);
 
    always @(S or I0 or I1) begin
        case(S)
            1'b0: O <= I0;
            1'b1: O <= I1;
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
 
    reg [2:0] q;
    wire [2:0] r;
 
    flipflop ff0 (
        .clk(clk),
        .D(q_in),
        .Q(q[0])
    );
 
    flipflop ff1 (
        .clk(clk),
        .D(mux_out),
        .Q(q[1])
    );
 
    flipflop ff2 (
        .clk(clk),
        .D(q[2]),
        .Q(Q)
    );
 
    mux_2_1 mux (
        .S(L),
        .I0(r_in),
        .I1(q[2]),
        .O(mux_out)
    );
 
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end
 
endmodule
