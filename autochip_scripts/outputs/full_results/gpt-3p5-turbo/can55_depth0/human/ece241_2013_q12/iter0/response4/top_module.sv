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
        if (S) begin
            Q <= Q << 1;
            Q[0] <= S;
        end
        addr <= {A, B, C};
        Z <= Q[addr];
    end
end

endmodule
