module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000:
            if (x == 0) begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end else begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end
        3'b001:
            if (x == 0) begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end else begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end
        3'b010:
            if (x == 0) begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end else begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
        3'b011:
            if (x == 0) begin
                Y0 <= 1'b0;
                z <= 1'b1;
            end else begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end
        3'b100:
            if (x == 0) begin
                Y0 <= 1'b1;
                z <= 1'b1;
            end else begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end
        default:
            Y0 <= 1'b0;
            z <= 1'b0;
    endcase
end

endmodule
