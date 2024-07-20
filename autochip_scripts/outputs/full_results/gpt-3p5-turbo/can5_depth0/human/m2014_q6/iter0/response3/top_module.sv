module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (w) begin
                        state <= 0;
                    end else begin
                        state <= 1;
                    end
                end
                1: begin
                    if (w) begin
                        state <= 3;
                    end else begin
                        state <= 2;
                    end
                end
                2: begin
                    if (w) begin
                        state <= 4;
                    end else begin
                        state <= 3;
                    end
                end
                3: begin
                    if (w) begin
                        state <= 0;
                    end else begin
                        state <= 5;
                    end
                end
                4: begin
                    if (w) begin
                        state <= 5;
                    end else begin
                        state <= 3;
                    end
                end
                5: begin
                    if (w) begin
                        state <= 2;
                    end else begin
                        state <= 3;
                    end
                end
            endcase
        end
    end
    
    always @(state or w) begin
        case (state)
            0: begin
                z <= 0;
            end
            1: begin
                z <= 0;
            end
            2: begin
                z <= 0;
            end
            3: begin
                z <= 0;
            end
            4: begin
                z <= 1;
            end
            5: begin
                z <= 0;
            end
            default: begin
                z <= 0;
            end
        endcase
    end
    
endmodule
