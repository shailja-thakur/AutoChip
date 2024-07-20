module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg disc_reg;
    reg flag_reg;
    reg err_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            disc_reg <= 1'b0;
            flag_reg <= 1'b0;
            err_reg <= 1'b0;
        end
        else begin
            case (state)
                3'b000: begin
                    if (in) begin
                        state <= 3'b001;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    if (in) begin
                        state <= 3'b010;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin
                    if (in) begin
                        state <= 3'b011;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin
                    if (in) begin
                        state <= 3'b100;
                        disc_reg <= 1'b1;
                        flag_reg <= 1'b0;
                        err_reg <= 1'b0;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
                3'b100: begin
                    if (in) begin
                        state <= 3'b101;
                    end
                    else begin
                        state <= 3'b110;
                        disc_reg <= 1'b0;
                        flag_reg <= 1'b1;
                        err_reg <= 1'b0;
                    end
                end
                3'b101: begin
                    if (in) begin
                        state <= 3'b100;
                    end
                    else begin
                        state <= 3'b110;
                        disc_reg <= 1'b0;
                        flag_reg <= 1'b1;
                        err_reg <= 1'b0;
                    end
                end
                3'b110: begin
                    if (in) begin
                        state <= 3'b111;
                        err_reg <= 1'b1;
                        disc_reg <= 1'b0;
                        flag_reg <= 1'b0;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
                3'b111: begin
                    if (in) begin
                        state <= 3'b111;
                    end
                    else begin
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end

    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

endmodule
