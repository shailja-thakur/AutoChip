module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg flag_next;
    reg disc_next;
    reg err_next;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin  // Initial state
                    if (in) begin
                        state <= 3'b001;
                    end
                end

                3'b001: begin  // One 1 received
                    if (in) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b010: begin  // Two 1s received
                    if (in) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b011: begin  // Three 1s received
                    if (in) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b100: begin  // Four 1s received
                    if (in) begin
                        state <= 3'b101;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b101: begin  // Five 1s received
                    if (in) begin
                        state <= 3'b110;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b110: begin  // Six 1s received
                    if (in) begin
                        state <= 3'b111;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b111: begin  // Seven or more 1s received
                    state <= 3'b000;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            3'b000: begin  // Initial state
                flag_next = 0;
                disc_next = 0;
                err_next = 0;
            end

            3'b001: begin  // One 1 received
                flag_next = 0;
                disc_next = 0;
                err_next = 0;
            end

            3'b010: begin  // Two 1s received
                flag_next = 0;
                disc_next = 0;
                err_next = 0;
            end

            3'b011: begin  // Three 1s received
                flag_next = 0;
                disc_next = 0;
                err_next = 0;
            end

            3'b100: begin  // Four 1s received
                flag_next = 0;
                disc_next = 0;
                err_next = 0;
            end

            3'b101: begin  // Five 1s received
                flag_next = 1;
                disc_next = 1;
                err_next = 0;
            end

            3'b110: begin  // Six 1s received
                flag_next = 1;
                disc_next = 0;
                err_next = 0;
            end

            3'b111: begin  // Seven or more 1s received
                flag_next = 0;
                disc_next = 0;
                err_next = 1;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            flag <= 0;
            disc <= 0;
            err <= 0;
        end else begin
            flag <= flag_next;
            disc <= disc_next;
            err <= err_next;
        end
    end

endmodule
