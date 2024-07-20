module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
reg [2:0] count_x;
reg [1:0] count_y;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;
        f <= 1'b0;
        g <= 1'b0;
        count_x <= 3'b000;
        count_y <= 2'b00;
    end else begin
        case (state)
            2'b00: begin   // State A
                f <= 1'b0;
                g <= 1'b0;
                count_x <= 3'b000;
                count_y <= 2'b00;
                if (x) begin
                    state <= 2'b01;   // Transition to state B
                end
            end
            2'b01: begin   // State B
                f <= 1'b1;
                g <= 1'b0;
                count_x <= 3'b000;
                count_y <= 2'b00;
                if (!x) begin
                    state <= 2'b10;   // Transition to state C
                end
            end
            2'b10: begin   // State C
                f <= 1'b0;
                count_y <= 2'b00;
                if (x) begin
                    state <= 2'b11;   // Transition to state D
                end
            end
            2'b11: begin   // State D
                if (x) begin
                    g <= 1'b1;
                    if (y) begin
                        count_x <= 3'b000;
                        count_y <= 2'b00;
                        state <= 2'b11;   // Remain in state D
                    end else begin
                        count_x <= count_x + 1;
                        if (count_x == 3'b101) begin
                            state <= 2'b00;   // Reset to state A
                        end
                    end
                end else begin
                    count_y <= count_y + 1;
                    if (count_y == 2'b11) begin
                        state <= 2'b00;   // Reset to state A
                    end
                end
            end
        endcase
    end
end

endmodule
