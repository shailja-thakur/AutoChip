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
                q <= q;
                state <= 0;
            end
            2'b01: begin
                q <= 1;
                state <= 0;
            end
            2'b10: begin
                q <= 0;
                state <= 0;
            end
            2'b11: begin
                q <= ~q;
                state <= ~state;
            end
        endcase
    end

endmodule
