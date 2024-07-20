module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg [2:0] next_state;
    reg out_disc, out_flag, out_err;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            out_disc <= 1'b0;
            out_flag <= 1'b0;
            out_err <= 1'b0;
        end else begin
            state <= next_state;
            out_disc <= 1'b0;
            out_flag <= 1'b0;
            out_err <= 1'b0;

            case (state)
                3'b000: begin // State 0
                    if (in) begin
                        next_state = 3'b001;
                        out_err <= 1'b0;
                    end else begin
                        next_state = 3'b000;
                        out_err <= 1'b0;
                    end
                end
                3'b001: begin // State 1
                    if (in) begin
                        next_state = 3'b010;
                        out_err <= 1'b0;
                    end else begin
                        next_state = 3'b000;
                        out_err <= 1'b0;
                    end
                end
                3'b010: begin // State 2
                    if (in) begin
                        next_state = 3'b011;
                        out_err <= 1'b0;
                    end else begin
                        next_state = 3'b000;
                        out_err <= 1'b0;
                    end
                end
                3'b011: begin // State 3
                    if (in) begin
                        next_state = 3'b011;
                        out_disc <= 1'b1;
                        out_err <= 1'b0;
                    end else begin
                        next_state = 3'b100;
                        out_err <= 1'b0;
                    end
                end
                3'b100: begin // State 4
                    if (in) begin
                        next_state = 3'b100;
                        out_err <= 1'b1;
                    end else if (!in) begin
                        next_state = 3'b101;
                        out_err <= 1'b0;
                    end
                end
                3'b101: begin // State 5
                    if (in) begin
                        next_state = 3'b011;
                        out_flag <= 1'b1;
                        out_err <= 1'b0;
                    end else begin
                        next_state = 3'b000;
                        out_err <= 1'b0;
                    end
                end
            endcase
        end
    end

    assign disc = out_disc;
    assign flag = out_flag;
    assign err = out_err;

endmodule
