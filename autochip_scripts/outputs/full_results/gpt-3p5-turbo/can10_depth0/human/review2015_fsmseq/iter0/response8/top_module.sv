module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg start_shifting_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end
        else begin
            case (state)
                0: begin
                    if (data) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                    end
                    else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 2;
                    end
                    else begin
                        state <= 3;
                    end
                end
                3: begin
                    if (data) begin
                        state <= 4;
                    end
                    else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (data) begin
                        state <= 2;
                    end
                    else begin
                        state <= 3;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_shifting_temp <= 0;
        end
        else if (state == 3) begin
            start_shifting_temp <= 1;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end
        else begin
            start_shifting <= start_shifting_temp;
        end
    end

endmodule
