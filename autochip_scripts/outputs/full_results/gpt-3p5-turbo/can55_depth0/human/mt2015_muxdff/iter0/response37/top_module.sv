module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;
        else
            Q <= D;
    end
    
endmodule
module mux_2to1(
    input A,
    input B,
    input S,
    output reg Y);
    
    always @(*) begin
        if (S)
            Y <= A;
        else
            Y <= B;
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
    wire [2:0] q_temp;
    wire q2_q1;
    
    flipflop ff1 (
        .clk(clk),
        .D(q2_q1),
        .reset(0),
        .Q(q[0])
    );
    
    flipflop ff2 (
        .clk(clk),
        .D(q_temp[0]),
        .reset(0),
        .Q(q[1])
    );
    
    flipflop ff3 (
        .clk(clk),
        .D(q_temp[1]),
        .reset(0),
        .Q(q[2])
    );
    
    mux_2to1 mux (
        .A(q[2]),
        .B(q[0]),
        .S(L),
        .Y(q2_q1)
    );
    
    always @(posedge clk) begin
        if (L) begin
            q <= {r_in, r_in, r_in};
        end else begin
            q <= q_temp;
        end
    end
    
    assign r = {r_in, r_in, r_in};
    assign Q = q_in;
    
endmodule
