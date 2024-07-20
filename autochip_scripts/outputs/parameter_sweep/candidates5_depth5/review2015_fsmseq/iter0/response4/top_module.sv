module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;   // 4-bit state variable

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;   // initial state
            start_shifting <= 0;
        end else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                        start_shifting <= 0;
                    end else begin
                        state <= 4'b0000;
                        start_shifting <= 0;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0011;
                        start_shifting <= 0;
                    end else begin
                        state <= 4'b0000;
                        start_shifting <= 0;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0110;
                        start_shifting <= 0;
                    end else begin
                        state <= 4'b0000;
                        start_shifting <= 0;
                    end
                end
                4'b0110: begin
                    if (data) begin
                        start_shifting <= 1;
                        state <= 4'b0000;
                    end else begin
                        state <= 4'b0000;
                        start_shifting <= 0;
                    end
                end
                default: begin
                    state <= 4'b0000;   // reset state if undefined state reached
                    start_shifting <= 0;
                end
            endcase
        end
    end

endmodule
