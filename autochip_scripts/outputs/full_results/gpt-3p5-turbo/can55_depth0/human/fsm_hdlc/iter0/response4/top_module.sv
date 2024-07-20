module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg next_disc, next_flag, next_err;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // wait for 0
                    if (in == 1'b1)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                end
                3'b001: begin // wait for 1
                    if (in == 1'b1)
                        state <= 3'b010;
                    else
                        state <= 3'b000;
                end
                3'b010: begin // wait for 1
                    if (in == 1'b1)
                        state <= 3'b011;
                    else
                        state <= 3'b000;
                end
                3'b011: begin // wait for 1
                    if (in == 1'b1)
                        state <= 3'b100;
                    else
                        state <= 3'b000;
                end
                3'b100: begin // wait for 1
                    if (in == 1'b1) begin
                        state <= 3'b101;
                        next_disc <= 1'b1;
                    end else
                        state <= 3'b000;
                end
                3'b101: begin // wait for 0
                    if (in == 1'b1) begin
                        state <= 3'b110;
                        next_err <= 1'b1;
                    end else begin
                        state <= 3'b010;
                        next_disc <= 1'b1;
                    end
                end
                3'b110: begin // wait for 1
                    if (in == 1'b0) begin
                        state <= 3'b111;
                        next_flag <= 1'b1;
                    end else begin
                        state <= 3'b011;
                        next_err <= 1'b1;
                    end
                end
                3'b111: begin // wait for 0
                    if (in == 1'b1) begin
                        state <= 3'b110;
                        next_err <= 1'b1;
                    end else
                        state <= 3'b010;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            disc <= 1'b0;
        else
            disc <= next_disc;

        flag <= next_flag;
        err <= next_err;

        next_disc <= 1'b0;
        next_flag <= 1'b0;
        next_err <= 1'b0;
    end

endmodule
