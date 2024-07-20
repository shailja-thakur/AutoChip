module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg disc_reg, flag_reg, err_reg;

    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b000;   // Initially transition to IDLE state
            disc_reg <= 0;
            flag_reg <= 0;
            err_reg <= 0;
        end else begin
            case (state)
                3'b000: begin    // IDLE state
                    if (in == 1) begin
                        state <= 3'b001;   // Transition to BIT1 state
                    end
                end
                3'b001: begin    // BIT1 state
                    if (in == 1) begin
                        state <= 3'b010;   // Transition to BIT2 state
                    end else begin
                        state <= 3'b000;   // Transition back to IDLE state
                    end
                end
                3'b010: begin    // BIT2 state
                    if (in == 1) begin
                        state <= 3'b011;   // Transition to BIT3 state
                    end else begin
                        state <= 3'b000;   // Transition back to IDLE state
                    end
                end
                3'b011: begin    // BIT3 state
                    if (in == 1) begin
                        state <= 3'b100;   // Transition to FLAG state
                    end else begin
                        state <= 3'b000;   // Transition back to IDLE state
                    end
                end
                3'b100: begin    // FLAG state
                    if (in == 1) begin
                        state <= 3'b101;   // Transition to ERR state
                    end else begin
                        state <= 3'b110;   // Transition to DISC state
                    end
                end
                3'b101: begin    // ERR state
                    state <= 3'b101;   // Stay in ERR state
                end
                3'b110: begin    // DISC state
                    state <= 3'b110;   // Stay in DISC state
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            3'b000: begin
                disc_reg <= 0;
                flag_reg <= 0;
                err_reg <= 0;
            end
            3'b001, 3'b010, 3'b011: begin
                if (in == 0)
                    disc_reg <= 0;
                else
                    disc_reg <= 1;
            end
            3'b100: begin
                flag_reg <= 1;
                err_reg <= 0;
            end
            3'b101: begin
                flag_reg <= 0;
                err_reg <= 1;
            end
            3'b110: begin
                flag_reg <= 0;
                err_reg <= 0;
            end
        endcase
    end

    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

endmodule
