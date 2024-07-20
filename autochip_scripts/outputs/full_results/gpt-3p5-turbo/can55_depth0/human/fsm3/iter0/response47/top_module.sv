module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // reset to state A
            out_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // state A
                    if (in) begin
                        state <= 2'b01; // next state B
                        out_reg <= 1'b0;
                    end
                end

                2'b01: begin // state B
                    if (in) begin
                        state <= 2'b10; // next state C
                        out_reg <= 1'b0;
                    end else begin
                        state <= 2'b01; // next state B
                        out_reg <= 1'b0;
                    end
                end

                2'b10: begin // state C
                    if (in) begin
                        state <= 2'b00; // next state A
                        out_reg <= 1'b0;
                    end else begin
                        state <= 2'b11; // next state D
                        out_reg <= 1'b0;
                    end
                end

                2'b11: begin // state D
                    if (in) begin
                        state <= 2'b10; // next state C
                        out_reg <= 1'b1;
                    else begin
                        state <= 2'b01; // next state B
                        out_reg <= 1'b0;
                    end
                end
            endcase
        end
    end

    assign out = out_reg;

endmodule
