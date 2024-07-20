module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00; // reset state A
        f <= 0;
        g <= 0;
    end else begin
        case (state)
            2'b00: begin // state A
                f <= 0;
                if (x == 1 && $past(x) == 0 && $past($past(x)) == 1)
                    state <= 2'b01; // transition to state B
            end
            2'b01: begin // state B
                f <= 1;
                state <= 2'b10; // transition to state C
            end
            2'b10: begin // state C
                if (x == 1 && $past(x) == 0 && $past($past(x)) == 1) begin
                    g <= 1;
                    state <= 2'b11; // transition to state D
                end else if ($past(x) == 0) begin
                    g <= 0;
                    state <= 2'b00; // back to state A
                end
            end
            2'b11: begin // state D
                if (y == 1)
                    g <= 1;
                else if ($past(y) == 0)
                    g <= 0;
                state <= 2'b11; // stay in state D
            end
        endcase
    end
end

endmodule
