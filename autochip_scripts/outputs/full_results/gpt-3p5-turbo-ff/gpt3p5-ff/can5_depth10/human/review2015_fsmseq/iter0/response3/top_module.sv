module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end
        else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end
                    else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0011;
                    end
                    else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0110;
                    end
                    else begin
                        state <= 4'b0000;
                    end
                end
                4'b0110: begin
                    if (data) begin
                        start_shifting <= 1;
                        state <= 4'b1111;
                    end
                    else begin
                        state <= 4'b0000;
                    end
                end
                4'b1111: begin
                    if (reset) begin
                        start_shifting <= 0;
                        state <= 4'b0000;
                    end
                    else begin
                        state <= 4'b1111;
                    end
                end
            endcase
        end
    end

endmodule
