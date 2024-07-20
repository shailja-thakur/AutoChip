module flipflop(
    input clk,
    input R,
    output reg Q
);

    always @(posedge clk) begin
        if (R)
            Q <= 1'b0;
        else
            Q <= Q;
    end
    
endmodule
module mux_2to1(
    input D0, D1,
    input S,
    output reg Y
);

    always @(*) begin
        if (S)
            Y <= D1;
        else
            Y <= D0;
    end
    
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
    wire [2:0] r;
    wire [2:0] q;
    wire q0, q1, q2;
    
    assign r = r_in;
    
    flipflop ff0(
        .clk(clk),
        .R(~L),
        .Q(q0)
    );
    
    flipflop ff1(
        .clk(clk),
        .R(~L),
        .Q(q1)
    );
    
    flipflop ff2(
        .clk(clk),
        .R(~L),
        .Q(q2)
    );
    
    mux_2to1 mux1(
        .D0(q1),
        .D1(r[2]),
        .S(q0),
        .Y(q[0])
    );
    
    mux_2to1 mux2(
        .D0(q[1]),
        .D1(r[1]),
        .S(q0),
        .Y(q[1])
    );
    
    mux_2to1 mux3(
        .D0(q[2]),
        .D1(r[0]),
        .S(q2),
        .Y(q[2])
    );
    
    always @(posedge clk) begin
        if (L)
            Q <= r;
        else
            Q <= q;
    end
    
endmodule
