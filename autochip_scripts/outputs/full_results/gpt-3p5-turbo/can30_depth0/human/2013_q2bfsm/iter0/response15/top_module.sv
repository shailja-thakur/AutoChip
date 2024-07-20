module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg f;
reg g;
reg [1:0] state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00; // state A
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        case(state)
            2'b00: begin // state A
                f <= 1'b0;
                if (x == 1'b1 && $fell(clk))
                    state <= 2'b01; // state B
            end
            2'b01: begin // state B
                f <= 1'b1;
                state <= 2'b10; // state C
            end
            2'b10: begin // state C
                if (x == 1'b0 && $fell(clk))
                    state <= 2'b11; // state D
            end
            2'b11: begin // state D
                if (x == 1'b1 && $fell(clk))
                    state <= 2'b00; // state A
                else if (y == 1'b1 && $fell(clk))
                    g <= 1'b1;
            end
        endcase
    end
end

endmodule
