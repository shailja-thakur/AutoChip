module flipflop(
    input clk,
    input reset,
    input D,
    output reg Q
    );

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
        end
    end

endmodule
module mux_2to1(
    input A,
    input B,
    input Sel,
    output reg Y
    );

    always @(*) begin
        if (Sel) begin
            Y <= B;
        end else begin
            Y <= A;
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

    wire [2:0] q;
    wire [2:0] r;

    flipflop ff0 (.clk(clk), .reset(L), .D(q_in), .Q(q[0]));
    flipflop ff1 (.clk(clk), .reset(L), .D(q[0]), .Q(q[1]));
    flipflop ff2 (.clk(clk), .reset(L), .D(q[1]), .Q(q[2]));

    mux_2to1 mux0 (.A(r_in), .B(q[0]), .Sel(L), .Y(Q));
    mux_2to1 mux1 (.A(Q), .B(q[2]), .Sel(~L), .Y(Q));

endmodule
