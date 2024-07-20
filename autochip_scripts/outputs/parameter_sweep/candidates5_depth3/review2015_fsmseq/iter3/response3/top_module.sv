module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg previous_bit;
    reg [1:0] compare;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
            compare <= 0;
        end else begin
            compare <= {compare[0], data};
            case(state)
                0: begin
                    if (compare == 2'b11) begin
                        state <= 1;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                1: begin
                    if (compare == 2'b01) begin
                        state <= 2;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                2: begin
                    if (compare == 2'b00) begin
                        state <= 3;
                        previous_bit <= 0;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                3: begin
                    if (compare == 2'b01) begin
                        state <= 4;
                        start_shifting <= 1;
                        previous_bit <= 1;
                    end else begin
                        state <= 0;
                        previous_bit <= data;
                    end
                end
                4: begin
                    if (compare == 2'b11) begin
                        state <= 4;
                        previous_bit <= 1;
                    end else if (compare == 2'b10) begin
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
