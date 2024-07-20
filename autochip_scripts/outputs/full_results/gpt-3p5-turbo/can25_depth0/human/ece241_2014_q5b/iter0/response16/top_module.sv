module top_module (
	input clk,
	input areset,
	input x,
	output z
);

    reg [1:0] state;
    reg z_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
            z_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (x) begin
                        state <= 2'b01;
                        z_reg <= 1'b1;
                    end else begin
                        state <= 2'b00;
                        z_reg <= 1'b0;
                    end
                end
                2'b01: begin
                    if (x) begin
                        state <= 2'b10;
                        z_reg <= 1'b0;
                    end else begin
                        state <= 2'b01;
                        z_reg <= 1'b1;
                    end
                end
                2'b10: begin
                    if (x) begin
                        state <= 2'b10;
                        z_reg <= 1'b0;
                    end else begin
                        state <= 2'b10;
                        z_reg <= 1'b1;
                    end
                end
                default: begin
                    state <= 2'b00;
                    z_reg <= 1'b0;
                end
            endcase
        end
    end

    assign z = z_reg;

endmodule
