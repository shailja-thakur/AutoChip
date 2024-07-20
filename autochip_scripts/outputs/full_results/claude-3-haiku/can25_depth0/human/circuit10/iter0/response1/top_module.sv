module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg s;

always @(posedge clk) begin
    case ({a, b})
        2'b00: begin
            q <= q;
            state <= s;
        end
        2'b01: begin
            q <= 1'b1;
            state <= 1'b0;
        end
        2'b10: begin
            q <= 1'b0;
            state <= 1'b0;
        end
        2'b11: begin
            q <= ~q;
            state <= ~s;
        end
    endcase

    s <= state;
end

endmodule
