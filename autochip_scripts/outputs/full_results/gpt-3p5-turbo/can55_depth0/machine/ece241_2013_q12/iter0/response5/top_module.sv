module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] q_temp;

always @(posedge clk) begin
    if (enable) begin
        q_temp <= {q[6:0], S};
    end
end

always @(A or B or C or q_temp) begin
    case ({A, B, C})
        3'b000: Z <= q_temp[0];
        3'b001: Z <= q_temp[1];
        3'b010: Z <= q_temp[2];
        3'b011: Z <= q_temp[3];
        3'b100: Z <= q_temp[4];
        3'b101: Z <= q_temp[5];
        3'b110: Z <= q_temp[6];
        3'b111: Z <= q_temp[7];
        default: Z <= 1'b0;
    endcase
end

always @(posedge clk) begin
    q <= q_temp;
end

endmodule
