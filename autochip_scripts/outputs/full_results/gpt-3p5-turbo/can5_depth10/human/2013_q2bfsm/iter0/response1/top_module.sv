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

reg [1:0] state, next_state;

always @(posedge clk, negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // state A
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        state <= next_state;
        f <= (state == 2'b01) ? 1'b1 : 1'b0;
        case (state)
            2'b00: begin
                if (x == 1'b1)
                    next_state = 2'b01; // state B
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (x == 1'b1)
                    next_state = 2'b10; // state C
                else
                    next_state = 2'b01;
            end
            2'b10: begin
                if (x == 1'b0)
                    next_state = 2'b11; // state D
                else
                    next_state = 2'b10;
            end
            2'b11: next_state = 2'b00; // state A
        endcase
    end
end

always @(posedge clk) begin
    if (state == 2'b10) begin // state C
        if (y == 1'b1)
            g <= 1'b1;
        else
            g <= 1'b0;
    end
end

endmodule
