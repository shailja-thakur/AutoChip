module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg start_searching;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_searching <= 1'b0;
            start_shifting <= 1'b0;
        end else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0100;
                    end
                end
                4'b0100: begin
                    if (data) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                default: begin
                    state <= 4'b0000;
                end
            endcase
            if (state == 4'b0011) begin
                start_searching <= 1'b1;
            end else begin
                start_searching <= 1'b0;
            end
            if (start_searching || start_shifting) begin
                start_shifting <= 1'b1;
            end else begin
                start_shifting <= 1'b0;
            end
        end
    end

endmodule
