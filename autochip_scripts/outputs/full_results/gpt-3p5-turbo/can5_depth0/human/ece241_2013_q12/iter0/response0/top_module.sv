module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] Q;
wire [2:0] ABC;

mux3 mux (
    .A(A),
    .B(B),
    .C(C),
    .Sel(ABC)
);

shift_reg_8bit shift_reg (
    .clk(clk),
    .enable(enable),
    .S(S),
    .Q(Q)
);

assign ABC = {A,B,C};

always @(posedge clk) begin
    if (ABC == 3'b000)
        Z <= Q[0];
    else if (ABC == 3'b001)
        Z <= Q[1];
    else if (ABC == 3'b010)
        Z <= Q[2];
    else if (ABC == 3'b011)
        Z <= Q[3];
    else if (ABC == 3'b100)
        Z <= Q[4];
    else if (ABC == 3'b101)
        Z <= Q[5];
    else if (ABC == 3'b110)
        Z <= Q[6];
    else if (ABC == 3'b111)
        Z <= Q[7];
end

endmodule
module shift_reg_8bit (
    input clk,
    input enable,
    input S,
    output [7:0] Q
);
reg [7:0] D;
reg [7:0] Q;

always @(posedge clk) begin
    if (enable)
        Q <= {S, Q[7:1]};
    else
        Q <= Q;
end

endmodule
module mux3 (
    input A,
    input B,
    input C,
    input [2:0] Sel,
    output wire Z
);
wire temp1;
wire temp2;

mux2 mux21 (
    .A(A),
    .B(B),
    .Sel(Sel[0]),
    .Z(temp1)
);

mux2 mux22 (
    .A(temp1),
    .B(B),
    .Sel(Sel[1]),
    .Z(temp2)
);

mux2 mux23 (
    .A(temp2),
    .B(C),
    .Sel(Sel[2]),
    .Z(Z)
);


endmodule
module mux2 (
    input A,
    input B,
    input Sel,
    output wire Z
);
assign Z = (Sel) ? B : A;

endmodule
