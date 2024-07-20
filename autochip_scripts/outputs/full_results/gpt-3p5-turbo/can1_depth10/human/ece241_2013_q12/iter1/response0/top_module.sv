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
        Q <= {S, Q[7:1]};
    end
    case ({A,B,C})
        3'b000: Z <= Q[0];
        3'b001: Z <= Q[1];
        3'b010: Z <= Q[2];
        3'b011: Z <= Q[3];
        3'b100: Z <= Q[4];
        3'b101: Z <= Q[5];
        3'b110: Z <= Q[6];
        3'b111: Z <= Q[7];
        default: Z <= Q[0];
    endcase
end

initial begin
    enable = 1;
    clk = 0;
    S = 0;
    A = 0;
    B = 0;
    C = 0;
    #5 enable = 0;
    S = 1;
    #5 S = 0;
    #5 S = 1;
    #5 S = 0;
    A = 0;
    B = 0;
    C = 0;
    #5 A = 0;
    B = 0;
    #5 B = 0;
    C = 0;
    #5 enable = 1;
    #5 A = 1;
    B = 0;
    C = 0;
    #5 A = 0;
    B = 0;
    #5 C = 1;
    #5 A = 0;
    B = 1;
    C = 0;
    #5 A = 1;
    B = 0;
    C = 0;
    #5 A = 0;
    B = 0;
    #5 C = 0;
    #5 enable = 0;
    #5 $finish;
end

always #2 clk = ~clk;

endmodule
