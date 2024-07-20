module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0;
            out_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (j) begin
                        state <= 2'b01;
                        out_reg <= 1'b0;
                    else
                        state <= 2'b00;
                        out_reg <= 1'b0;
                    end
                end
                2'b01: begin
                    if (k) begin
                        state <= 2'b00;
                        out_reg <= 1'b1;
                    else
                        state <= 2'b01;
                        out_reg <= 1'b1;
                    end
                end
                default: begin
                    state <= 2'b00;
                    out_reg <= 1'b0;
                end
            endcase
        end
    end

    assign out = out_reg;

endmodule
