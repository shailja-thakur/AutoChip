module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [1:0] state;
    reg start_flag;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            start_flag <= 0;
        end else begin
            case (state)
                2'b00: begin
                    if (data) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (data) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (data) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin
                    if (!data) begin
                        state <= 2'b00;
                    end
                    start_flag <= 1;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else begin
            start_shifting <= start_flag;
        end
    end

endmodule
