module flipflop(input clk, input D, output reg Q);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux2to1(input S, input A, input B, output reg Y);
    always @(S or A or B) begin
        if (S == 0) begin
            Y <= A;
        end else begin
            Y <= B;
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

    wire D;
    wire [1:0] mux_out;
    
    flipflop FF1 (.clk(clk), .D(q_in), .Q(D));
    
    mux2to1 MUX1 (.S(L), .A(q_in), .B(r_in), .Y(mux_out[0]));
    mux2to1 MUX2 (.S(L), .A(D), .B(mux_out[0]), .Y(mux_out[1]));
    mux2to1 MUX3 (.S(L), .A(mux_out[1]), .B(mux_out[0]), .Y(Q));
    
endmodule
