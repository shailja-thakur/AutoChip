module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // State 0
                    if (in == 1'b0) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin // State 1
                    if (in == 1'b0) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin // State 2
                    if (in == 1'b1) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin // State 3
                    if (in == 1'b1) begin
                        state <= 3'b100;
                        disc <= 1'b1;
                    end else if (in == 1'b0) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b100: begin // State 4
                    if (in == 1'b0) begin
                        state <= 3'b101;
                        flag <= 1'b1;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b101: begin // State 5
                    if (in == 1'b1) begin
                        state <= 3'b110;
                        err <= 1'b1;
                    end else if (in == 1'b0) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b110: begin // State 6
                    if (in == 1'b1) begin
                        state <= 3'b111;
                        err <= 1'b1;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b111: begin // State 7
                    if (in == 1'b1) begin
                        state <= 3'b111;
                        err <= 1'b1;
                    end else begin
                        state <= 3'b000;
                    end
                end
                default: begin
                    state <= 3'b000;
                end
            endcase
        end
    end

endmodule
