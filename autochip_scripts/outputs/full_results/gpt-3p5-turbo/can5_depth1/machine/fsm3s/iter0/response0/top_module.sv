module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            out_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (in) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (in) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (in) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin
                    if (in) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b10;
                    end
                end
            endcase
        end
    end

    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
endmodule
