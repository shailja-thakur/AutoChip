module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin // State A
                    if (in) begin
                        state <= 2'b01; // State B
                    end else begin
                        state <= 2'b00; // Remain in State A
                    end
                end
                2'b01: begin // State B
                    if (in) begin
                        state <= 2'b01; // Remain in State B
                    end else begin
                        state <= 2'b10; // State C
                    end
                end
                2'b10: begin // State C
                    if (in) begin
                        state <= 2'b11; // State D
                    end else begin
                        state <= 2'b00; // State A
                    end
                end
                2'b11: begin // State D
                    if (in) begin
                        state <= 2'b01; // State B
                    end else begin
                        state <= 2'b10; // State C
                    end
                end
            endcase
        end
    end

    always @(state) begin
        if (state == 2'b11) begin // State D
            out_reg <= 1'b1;
        end else begin
            out_reg <= 1'b0;
        end
    end

    assign out = out_reg;

endmodule
