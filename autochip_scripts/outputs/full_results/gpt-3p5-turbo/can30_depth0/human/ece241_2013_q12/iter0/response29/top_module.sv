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
    
    dff #(1) U0 (.clk(clk), .D(S), .Q(Q[0]), .enable(enable));
    dff #(1) U1 (.clk(clk), .D(Q[0]), .Q(Q[1]), .enable(enable));
    dff #(1) U2 (.clk(clk), .D(Q[1]), .Q(Q[2]), .enable(enable));
    dff #(1) U3 (.clk(clk), .D(Q[2]), .Q(Q[3]), .enable(enable));
    dff #(1) U4 (.clk(clk), .D(Q[3]), .Q(Q[4]), .enable(enable));
    dff #(1) U5 (.clk(clk), .D(Q[4]), .Q(Q[5]), .enable(enable));
    dff #(1) U6 (.clk(clk), .D(Q[5]), .Q(Q[6]), .enable(enable));
    dff #(1) U7 (.clk(clk), .D(Q[6]), .Q(Q[7]), .enable(enable));
    
    mux3x8 #(1) M0 (.A(A), .B(B), .C(C), .S(ABC), .Z(Z));
    
    assign ABC = {A, B, C};
    
endmodule
module dff (
    input clk,
    input D,
    output reg Q,
    input enable
);
    always @(posedge clk) begin
        if (enable) begin
            Q <= D;
        end
    end
endmodule
module mux3x8 (
    input [2:0] A,
    input [2:0] B,
    input [2:0] C,
    input [2:0] S,
    output reg Z
);
    always @(*) begin
        case(S)
            3'b000: Z <= A[0];
            3'b001: Z <= A[1];
            3'b010: Z <= A[2];
            3'b011: Z <= B[0];
            3'b100: Z <= B[1];
            3'b101: Z <= B[2];
            3'b110: Z <= C[0];
            3'b111: Z <= C[1];
        endcase
    end
endmodule
