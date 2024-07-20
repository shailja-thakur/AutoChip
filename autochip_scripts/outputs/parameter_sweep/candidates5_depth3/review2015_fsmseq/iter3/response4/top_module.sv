module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg previous_bit;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case(state)
                0: begin
                    if (previous_bit == 1'b1 && data == 1'b1) begin
                        state <= 4;
                        previous_bit <= data;
                        start_shifting <= 1;
                    end else begin
                        state <= 1;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end
                end
                1: begin
                    if (previous_bit == 1'b1 && data == 1'b0) begin
                        state <= 0;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else if (data == 1'b1) begin
                        state <= 2;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else begin
                        state <= 1;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end
                end
                2: begin
                    if (previous_bit == 1'b0 && data == 1'b0) begin
                        state <= 3;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else if (data == 1'b1) begin
                        state <= 2;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else begin
                        state <= 1;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end
                end
                3: begin
                    if (previous_bit == 1'b0 && data == 1'b1) begin
                        state <= 4;
                        previous_bit <= data;
                        start_shifting <= 1;
                    end else if (data == 1'b1) begin
                        state <= 2;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else begin
                        state <= 1;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end
                end
                4: begin
                    if (previous_bit == 1'b0 && data == 1'b1) begin
                        state <= 4;
                        previous_bit <= data;
                        start_shifting <= 1;
                    end else if (data == 1'b1) begin
                        state <= 2;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end else begin
                        state <= 1;
                        previous_bit <= data;
                        start_shifting <= 0;
                    end
                end
            endcase
        end
    end

endmodule
