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
reg [2:0] addr;

always @(posedge clk) begin
    if (enable) begin
        Q[0] <= S;
        Q[1] <= Q[0];
        Q[2] <= Q[1];
        Q[3] <= Q[2];
        Q[4] <= Q[3];
        Q[5] <= Q[4];
        Q[6] <= Q[5];
        Q[7] <= Q[6];
    end
    addr <= {A, B, C};
    case (addr)
        3'd0: Z <= Q[0];
        3'd1: Z <= Q[1];
        3'd2: Z <= Q[2];
        3'd3: Z <= Q[3];
        3'd4: Z <= Q[4];
        3'd5: Z <= Q[5];
        3'd6: Z <= Q[6];
        3'd7: Z <= Q[7];
    endcase
end

endmodule
