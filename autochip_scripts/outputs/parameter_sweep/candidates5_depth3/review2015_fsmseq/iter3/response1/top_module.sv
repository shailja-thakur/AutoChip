module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg previous_bit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
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
                    if (previous_bit == 1'b1 && data == 1'b1) begin
                        state <= 2;
                        previous_bit <= 1;
                    end else if (data == 1'b0) begin
                        state <= 0;
                        previous_bit <= 0;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                2: begin
                    if (previous_bit == 1'b1 && data == 1'b0) begin
                        state <= 3;
                        previous_bit <= 0;
                    end else if (data == 1'b1) begin
                        state <= 1;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                3: begin
                    if (previous_bit == 1'b1 && data == 1'b1) begin
                        state <= 4;
                        previous_bit <= 1;
                    end else if (data == 1'b1) begin
                        state <= 1;
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
            endcase
        end
    end

endmodule
