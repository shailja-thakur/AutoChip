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
reg [2:0] address;

always @(posedge clk) begin
    if (enable) begin
        Q[0] <= S; // Shift register input
        Q[1] <= Q[0];
        Q[2] <= Q[1];
        Q[3] <= Q[2];
        Q[4] <= Q[3];
        Q[5] <= Q[4];
        Q[6] <= Q[5];
        Q[7] <= Q[6];
    end
    if (A == 0 && B == 0 && C == 0) // ABC is 000
        Z <= Q[0];
    else if (A == 0 && B == 0 && C == 1) // ABC is 001
        Z <= Q[1];
    else if (A == 0 && B == 1 && C == 0) // ABC is 010
        Z <= Q[2];
    else if (A == 0 && B == 1 && C == 1) // ABC is 011
        Z <= Q[3];
    else if (A == 1 && B == 0 && C == 0) // ABC is 100
        Z <= Q[4];
    else if (A == 1 && B == 0 && C == 1) // ABC is 101
        Z <= Q[5];
    else if (A == 1 && B == 1 && C == 0) // ABC is 110
        Z <= Q[6];
    else if (A == 1 && B == 1 && C == 1) // ABC is 111
        Z <= Q[7];
end

endmodule
