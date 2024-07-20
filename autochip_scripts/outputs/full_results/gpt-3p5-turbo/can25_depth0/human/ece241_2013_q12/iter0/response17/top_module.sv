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

mux8x1 mux (
    .A(ABC),
    .B(Q),
    .Y(Z)
);

always @(posedge clk) begin
    if (enable) begin
        Q[7] <= S;
        Q[6] <= Q[7];
        Q[5] <= Q[6];
        Q[4] <= Q[5];
        Q[3] <= Q[4];
        Q[2] <= Q[3];
        Q[1] <= Q[2];
        Q[0] <= Q[1];
    end
end

assign ABC = {A, B, C};

endmodule
module mux8x1 (
    input [2:0] A,
    input [7:0] B,
    output reg Y
);

always @(*) begin
    case (A)
        3'b000: Y <= B[0];
        3'b001: Y <= B[1];
        3'b010: Y <= B[2];
        3'b011: Y <= B[3];
        3'b100: Y <= B[4];
        3'b101: Y <= B[5];
        3'b110: Y <= B[6];
        3'b111: Y <= B[7];
        default: Y <= 1'b0;
    endcase
end

endmodule
