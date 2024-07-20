module top_module (
    input clk,
    input a, 
    output reg q
);

always @(posedge clk) begin
    case (a)
        1'b0: begin
            q <= 1'b1;
        end
        1'b1: begin
            q <= 1'b0;
        end
    endcase
end

endmodule
