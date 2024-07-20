module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    case ({a, b})
        2'b00: begin
            state <= 0;
            q <= 0;
        end
        2'b01: begin
            state <= 0;
            q <= 1;
        end
        2'b10: begin
            state <= 1;
            q <= q;
        end
        2'b11: begin
            state <= 0;
            q <= 0;
        end
    endcase
end

endmodule
