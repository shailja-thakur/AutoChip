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
reg [2:0] select_reg;
wire [2:0] select;

assign select = select_reg;

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

    case ({A, B, C})
        3'b000: select_reg <= 3'b000;
        3'b001: select_reg <= 3'b001;
        3'b010: select_reg <= 3'b010;
        3'b011: select_reg <= 3'b011;
        3'b100: select_reg <= 3'b100;
        3'b101: select_reg <= 3'b101;
        3'b110: select_reg <= 3'b110;
        3'b111: select_reg <= 3'b111;
    endcase

    Z <= Q[select];
end

endmodule
