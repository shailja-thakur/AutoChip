module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
        end else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else if (!data) begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0010;
                    end else if (!data) begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (data) begin
                        state <= 4'b0001;
                    end else if (!data) begin
                        state <= 4'b0000;
                    end
                end
                default: begin
                    state <= 4'b0000;
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 0;
        end else begin
            if (state == 4'b0010) begin
                start_shifting <= 1;
            end else begin
                start_shifting <= 0;
            end
        end
    end

endmodule
