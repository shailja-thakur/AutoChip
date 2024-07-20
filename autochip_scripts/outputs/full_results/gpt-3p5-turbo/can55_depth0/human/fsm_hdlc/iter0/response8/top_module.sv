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
            state <= 0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (state)
                0: begin
                    if (in) begin
                        state <= 1;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                1: begin
                    if (in) begin
                        state <= 2;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                2: begin
                    if (in) begin
                        state <= 3;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                3: begin
                    if (in) begin
                        state <= 4;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                4: begin
                    if (in) begin
                        state <= 5;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                5: begin
                    if (in) begin
                        state <= 6;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                6: begin
                    if (in) begin
                        state <= 7;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                7: begin
                    if (in) begin
                        state <= 8;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 0;
                    end else begin
                        state <= 0;
                        next_disc <= 1;
                        next_flag <= 0;
                        next_err <= 0;
                    end
                end
                8: begin
                    if (in) begin
                        state <= 8;
                        next_disc <= 0;
                        next_flag <= 0;
                        next_err <= 1;
                    end else begin
                        state <= 0;
                        next_disc <= 0;
                        next_flag <= 1;
                        next_err <= 0;
                    end
                end
                default: begin
                    state <= 0;
                    next_disc <= 0;
                    next_flag <= 0;
                    next_err <= 0;
                end
            endcase
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= next_disc;
            flag <= next_flag;
            err <= next_err;
        end
    end
    
endmodule
