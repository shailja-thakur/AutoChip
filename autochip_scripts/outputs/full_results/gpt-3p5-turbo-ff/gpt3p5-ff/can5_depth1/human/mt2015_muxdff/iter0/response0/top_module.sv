module flipflop(
    input CLK,
    input D,
    output reg Q
);
    
    always @(posedge CLK)
    begin
        Q <= D;
    end 
endmodule
module mux_2to1(
    input A,
    input B,
    input S,
    output reg Y
);

    always @*
    begin
        if(S == 0)
            Y = A;
        else
            Y = B;
    end
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
    wire q_out;

    flipflop ff (.CLK(clk), .D(q_in), .Q(q_out));
    mux_2to1 mux (.A(q_out), .B(r_in), .S(L), .Y(Q));

    always @(posedge clk)
    begin
        r <= r_in;
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

endmodule
