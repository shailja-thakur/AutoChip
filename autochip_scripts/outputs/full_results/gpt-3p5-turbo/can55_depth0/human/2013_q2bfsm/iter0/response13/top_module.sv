module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
reg [2:0] x_history;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // state A
        f <= 0;
        g <= 0;
        x_history <= 3'b000;
    end else begin
        case (state)
            2'b00: begin // state A
                f <= 0;
                g <= 0;
                if (x_history == 3'b101)
                    state <= 2'b10; // state B
                else
                    state <= 2'b00;
                x_history <= {x_history[1:0], x};
            end

            2'b01: begin // state C
                f <= 1;
                g <= 0;
                state <= 2'b01; // stay in state C
                x_history <= {x_history[1:0], x};
            end

            2'b10: begin // state B
                f <= 0;
                g <= 0;
                if (y == 1) begin
                    state <= 2'b11; // state D
                    x_history <= 3'b000;
                end else if (x_history == 3'b101)
                    state <= 2'b01; // state C
                else
                    state <= 2'b10;
                x_history <= {x_history[1:0], x};
            end

            2'b11: begin // state D
                f <= 0;
                g <= 1;
                if (y != 1)
                    g <= 0;
                state <= 2'b11; // stay in state D
            end
        endcase
    end
end

endmodule
