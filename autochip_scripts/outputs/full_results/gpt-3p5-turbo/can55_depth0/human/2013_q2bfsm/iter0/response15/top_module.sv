module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
    reg [1:0] state;
    reg f_next, g_next;
    always @(posedge clk) begin
        if (!resetn) begin
            state <= 2'b00;  // state A
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            case (state)
                2'b00: begin  // state A
                    f <= 1'b0;
                    g <= 1'b0;
                    if (x) begin
                        state <= 2'b01;  // state B
                        f_next <= 1'b1;
                    end else begin
                        state <= 2'b00;  // stay in state A
                        f_next <= 1'b0;
                    end
                end
                2'b01: begin  // state B
                    f <= f_next;
                    g <= 1'b0;
                    if (x) begin
                        state <= 2'b10;  // state C
                    end else begin
                        state <= 2'b00;  // return to state A
                    end
                end
                2'b10: begin  // state C
                    f <= 1'b0;
                    if (x) begin
                        state <= 2'b11;  // state D
                        g_next <= 1'b0;
                    end else begin
                        state <= 2'b00;  // return to state A
                    end
                end
                2'b11: begin  // state D
                    f <= 1'b0;
                    g <= g_next;
                    if (y) begin
                        state <= 2'b11;  // stay in state D
                    end else begin
                        state <= 2'b00;  // return to state A
                        g_next <= 1'b0;
                    end
                end
                default: begin
                    state <= 2'b00;  // return to state A
                end
            endcase
        end
    end
endmodule
