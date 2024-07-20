module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
reg [2:0] x_count;
reg [1:0] y_count;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00;     // Reset state A
        f <= 1'b0;
        g <= 1'b0;
        x_count <= 0;
        y_count <= 0;
    end else begin
        case (state)
            2'b00: begin   // State A
                f <= 1'b0;
                g <= 1'b0;
                x_count <= 0;
                if (x) begin
                    state <= 2'b01;   // Transition to state B
                end
            end
            2'b01: begin   // State B
                f <= 1'b1;
                g <= 1'b0;
                x_count <= 0;
                if (!x) begin
                    state <= 2'b10;   // Transition to state C
                end
            end
            2'b10: begin   // State C
                f <= 1'b0;
                x_count <= (x_count == 3) ? 0 : x_count + 1;
                if (x && (x_count == 3)) begin
                    state <= 2'b11;   // Transition to state D
                end
            end
            2'b11: begin   // State D
                if (x && (x_count == 3)) begin
                    g <= 1'b1;
                    if (y) begin
                        y_count <= 0;
                        state <= 2'b11;   // Remain in state D
                    end else begin
                        state <= 2'b00;   // Reset to state A
                    end
                end else begin
                    y_count <= (y_count == 2) ? 2 : y_count + 1;
                    if (y && (y_count == 2)) begin
                        state <= 2'b11;   // Remain in state D
                    end else begin
                        state <= 2'b00;   // Reset to state A
                    end
                end
            end
        endcase
    end
end

endmodule
