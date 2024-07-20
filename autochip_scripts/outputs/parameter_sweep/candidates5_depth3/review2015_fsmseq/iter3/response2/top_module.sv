module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg previous_bit;
    reg reset_sync;

    always @(posedge clk) begin
        if (reset_sync) begin
            state <= 0;
        end else begin
            case(state)
                0: begin
                    if (data == 1'b1) begin
                        state <= 1;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                1: begin
                    if (data == 1'b1) begin
                        state <= 2;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                2: begin
                    if (data == 1'b0) begin
                        state <= 3;
                        previous_bit <= 0;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                3: begin
                    if (data == 1'b1) begin
                        state <= 4;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                4: begin
                    if (previous_bit == 1'b1 && data == 1'b1) begin
                        state <= 4;
                        previous_bit <= 1;
                    end else if (data == 1'b0) begin
                        state <= 0;
                        previous_bit <= 0;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        reset_sync <= reset;
        if (reset_sync) begin
            start_shifting <= 0;
        end else begin
            if (state == 4) begin
                start_shifting <= 1;
            end else begin
                start_shifting <= 0;
            end
        end
    end

endmodule
