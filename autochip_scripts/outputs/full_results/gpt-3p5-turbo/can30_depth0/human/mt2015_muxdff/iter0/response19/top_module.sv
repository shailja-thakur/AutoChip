module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);
    always @(*) begin
        if (S == 0)
            Y <= D0;
        else
            Y <= D1;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input [2:0] r_in,
    output reg Q
);
    wire [2:0] q_temp1, q_temp2;
    wire [2:0] q_temp3, q_temp4, q_temp5;
    
    flipflop ff1 (.clk(clk), .D(q_temp1[0]), .Q(q_temp2[0]));
    flipflop ff2 (.clk(clk), .D(q_temp1[1]), .Q(q_temp2[1]));
    flipflop ff3 (.clk(clk), .D(q_temp1[2]), .Q(q_temp2[2]));
    
    mux_2to1 mux1 (.S(L), .D0(q_temp1[0]), .D1(r_in[0]), .Y(q_temp3[0]));
    mux_2to1 mux2 (.S(L), .D0(q_temp1[1]), .D1(r_in[1]), .Y(q_temp3[1]));
    mux_2to1 mux3 (.S(L), .D0(q_temp1[2]), .D1(r_in[2]), .Y(q_temp3[2]));
    
    mux_2to1 mux4 (.S(q_temp2[2]), .D0(q_temp2[0]), .D1(q_temp3[0]), .Y(q_temp4[0]));
    mux_2to1 mux5 (.S(q_temp2[2]), .D0(q_temp2[1]), .D1(q_temp3[1]), .Y(q_temp4[1]));
    mux_2to1 mux6 (.S(q_temp2[2]), .D0(q_temp2[2]), .D1(q_temp3[2]), .Y(q_temp4[2]));
    
    mux_2to1 mux7 (.S(q_temp4[1]), .D0(q_temp4[0]), .D1(q_temp3[0]), .Y(q_temp5[0]));
    mux_2to1 mux8 (.S(q_temp4[1]), .D0(q_temp4[1]), .D1(q_temp3[1]), .Y(q_temp5[1]));
    mux_2to1 mux9 (.S(q_temp4[1]), .D0(q_temp4[2]), .D1(q_temp3[2]), .Y(q_temp5[2]));
    
    mux_2to1 mux10 (.S(q_temp5[2]), .D0(q_temp4[0]), .D1(q_temp3[0]), .Y(Q));
endmodule
