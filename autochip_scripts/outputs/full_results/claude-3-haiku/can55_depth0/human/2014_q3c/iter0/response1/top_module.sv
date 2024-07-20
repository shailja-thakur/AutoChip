module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case (y)
        3'd0: begin
            Y0 <= x ? 1'b1 : 1'b0;
            z <= 1'b0;
        end
        3'd1: begin
            Y0 <= x ? 1'b0 : 1'b1;
            z <= 1'b0;
        end
        3'd2: begin
            Y0 <= x ? 1'b1 : 1'b0;
            z <= 1'b0;
        end
        3'd3: begin
            Y0 <= x ? 1'b0 : 1'b1;
            z <= 1'b1;
        end
        3'd4: begin
            Y0 <= x ? 1'b1 : 1'b0;
            z <= 1'b1;
        end
        default: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
    endcase
end

endmodule
