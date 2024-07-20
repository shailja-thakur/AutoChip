module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [3:0] state;
    reg [2:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            counter <= 3'b000;
        end else begin
            case (state)
                4'b0000: begin // S0
                    if (in == 1'b0) begin
                        state <= 4'b0010;
                        counter <= 3'b000;
                    end else begin
                        counter <= counter + 1;
                        if (counter == 3'b100) begin
                            state <= 4'b0100;
                            counter <= 3'b000;
                        end
                    end
                end
                4'b0010: begin // S1
                    if (in == 1'b0) begin
                        state <= 4'b0010;
                        counter <= 3'b000;
                    end else begin
                        state <= 4'b0011;
                        counter <= 3'b000;
                        disc <= 1'b1;
                    end
                end
                4'b0011: begin // S2
                    if (in == 1'b0) begin
                        state <= 4'b0000;
                        counter <= 3'b000;
                        flag <= 1'b1;
                    end else begin
                        counter <= counter + 1;
                        if (counter == 3'b100) begin
                            state <= 4'b0110;
                            counter <= 3'b000;
                        end
                    end
                end
                4'b0100: begin // S3
                    if (in == 1'b0) begin
                        state <= 4'b0100;
                        counter <= 3'b000;
                    end else begin
                        state <= 4'b0101;
                        counter <= 3'b000;
                        disc <= 1'b1;
                    end
                end
                4'b0101: begin // S4
                    if (in == 1'b0) begin
                        state <= 4'b0011;
                        counter <= 3'b000;
                        flag <= 1'b1;
                    end else begin
                        counter <= counter + 1;
                        if (counter == 3'b011) begin
                            state <= 4'b0110;
                            counter <= 3'b000;
                        end else begin
                            state <= 4'b0101;
                        end
                    end
                end
                4'b0110: begin // S5
                    if (in == 1'b0) begin
                        state <= 4'b0100;
                        counter <= 3'b000;
                        disc <= 1'b1;
                    end else begin
                        counter <= counter + 1;
                        if (counter == 3'b000) begin
                            state <= 4'b0000;
                            counter <= 3'b000;
                            flag <= 1'b1;
                        end
                    end
                end
                default: begin
                    state <= 4'b0000;
                    counter <= 3'b000;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                4'b0011, 4'b0101: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end
                4'b0110: begin
                    disc <= 1'b0;
                    flag <= 1'b1;
                    err <= 1'b0;
                end
                default: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b1;
                end
            endcase
        end
    end

endmodule
