module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 4'b00;
            start_shifting <= 1'b0;
        end else begin
            case (state)
                4'b00: begin
                    if (data) begin
                        state <= 4'b01;
                    end else begin
                        state <= 4'b00;
                    end
                end
                4'b01: begin
                    if (data) begin
                        state <= 4'b10;
                    end else begin
                        state <= 4'b00;
                    end
                end
                4'b10: begin
                    if (data) begin
                        state <= 4'b11;
                    end else begin
                        state <= 4'b00;
                    end
                end
                4'b11: begin
                    if (data) begin
                        state <= 4'b11;
                        start_shifting <= 1'b1;
                    end else begin
                        state <= 4'b00;
                    end
                end
            endcase
        end
    end

endmodule
