module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @ (posedge clk) begin
    if (state) begin
        q <= a & b;
    end else begin
        q <= 1'b0;
    end
    case ({a, b})
        2'd1: state <= 1'b1;
        default: state <= 1'b0;
    endcase
end

endmodule
