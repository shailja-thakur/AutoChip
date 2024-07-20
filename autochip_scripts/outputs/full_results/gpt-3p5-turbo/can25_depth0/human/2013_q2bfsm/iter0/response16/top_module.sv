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
reg [2:0] history;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // state A
        f <= 0;
        g <= 0;
    end else begin
        case (state)
            2'b00: begin // state A
                f <= 0;
                g <= 0;
                if (x == 1'b1) begin
                    state <= 2'b01;
                    history <= 3'b100;
                end
            end
            2'b01: begin // state B
                f <= 1;
                state <= 2'b10;
            end
            2'b10: begin // state C
                if (x == 1'b0)
                    history[2:0] <= {history[1:0], x};
                else
                    history[2:0] <= {history[1:0], x};
                if (history == 3'b101) begin
                    state <= 2'b11;
                end
            end
            2'b11: begin // state D
                g <= 1;
                if (y == 1'b1) begin
                    state <= 2'b11;
                end else begin
                    state <= 2'b00; // state A
                    g <= 0;
                end
            end
            default: begin
                state <= 2'b00; // state A
                f <= 0;
                g <= 0;
            end
        endcase
    end
end

endmodule
