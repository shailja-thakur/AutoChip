module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [6:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            count <= 0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (state)
                0: begin
                    if (in) begin
                        state <= 1;
                        count <= 1;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                1: begin
                    if (in) begin
                        state <= 2;
                        count <= 2;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                2: begin
                    if (in) begin
                        state <= 3;
                        count <= 3;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                3: begin
                    if (in) begin
                        state <= 4;
                        count <= 4;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                4: begin
                    if (in) begin
                        state <= 5;
                        count <= 5;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                5: begin
                    if (in) begin
                        state <= 6;
                        count <= 6;
                    end else begin
                        state <= 0;
                        count <= 0;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                6: begin
                    if (in) begin
                        state <= 7;
                        count <= 7;
                        err <= 1;
                    end else begin
                        state <= 6;
                        count <= 6;
                        err <= 0;
                    end
                end
                7: begin
                    if (in) begin
                        state <= 7;
                        count <= count + 1;
                        err <= 1;
                    end else begin
                        state <= 0;
                        count <= 0;
                        flag <= 1;
                        err <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case (count)
            1: disc <= 1;
            5: begin
                disc <= 1;
                flag <= 1;
            end
            default: disc <= 0;
        endcase
    end

endmodule
