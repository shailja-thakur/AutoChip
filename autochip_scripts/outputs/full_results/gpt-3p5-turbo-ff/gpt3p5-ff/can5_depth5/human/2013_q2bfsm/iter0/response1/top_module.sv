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
reg [1:0] y_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00; // state A
        f <= 1'b0;
        g <= 1'b0;
        x_history <= 3'b000;
        y_count <= 2'b00;
    end else begin
        case (state)
            2'b00: begin // state A
                if (resetn) begin
                    state <= 2'b01; // state B
                    f <= 1'b0;
                end
            end
            2'b01: begin // state B
                f <= 1'b1;
                state <= 2'b10; // state C
            end
            2'b10: begin // state C
                // Shifting x_history
                x_history <= {x_history[1:0], x};
                if (x_history == 3'b101) begin
                    state <= 2'b11; // state D
                end
            end
            2'b11: begin // state D
                g <= 1'b1;
                if (y == 1'b1) begin
                    state <= 2'b11; // Stay in state D
                    y_count <= 2'b00;
                else begin
                    if (y_count == 2'b11) begin
                        state <= 2'b11; // Stay in state D
                    end else begin
                        y_count <= y_count + 1;
                    end
                end
            end
        endcase
    end
end

endmodule
