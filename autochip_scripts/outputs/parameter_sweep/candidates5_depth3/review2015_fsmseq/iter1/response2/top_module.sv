module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg previous_bit;
    reg sync_reset;
    
    always @(posedge clk) begin
        if (reset) begin
            sync_reset <= 1;
        end else begin
            sync_reset <= 0;
        end
    end

    always @(posedge clk) begin
        if (sync_reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case(state)
                0: begin
                    if (data == 1'b1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data == 1'b1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data == 1'b0) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data == 1'b1) begin
                        start_shifting <= 1;
                        state <= 4;
                    end else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (data == 1'b1) begin
                        state <= 4;
                    end else if (data == 1'b0) begin
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule
