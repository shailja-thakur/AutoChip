module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [1:0] input_buffer;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            input_buffer <= 2'b0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1'b1) begin
                        input_buffer <= {input_buffer[0], 1'b1};
                        if (input_buffer == 2'b11)
                            state <= 1;
                    end else
                        input_buffer <= {input_buffer[0], 1'b0};
                end
                1: begin
                    if (data == 1'b1) begin
                        input_buffer <= {input_buffer[0], 1'b1};
                        if (input_buffer == 2'b11)
                            state <= 2;
                    end else
                        input_buffer <= {input_buffer[0], 1'b0};
                end
                2: begin
                    if (data == 1'b0) begin
                        input_buffer <= {input_buffer[0], 1'b0};
                        if (input_buffer == 2'b01)
                            state <= 3;
                    end else
                        input_buffer <= {input_buffer[0], 1'b1};
                end
                3: begin
                    if (data == 1'b1) begin
                        input_buffer <= {input_buffer[0], 1'b1};
                        if (input_buffer == 2'b11) begin
                            state <= 0;
                            start_shifting <= 1;
                        end
                    end else
                        input_buffer <= {input_buffer[0], 1'b0};
                end
                default: state <= 0;
            endcase
        end
    end
endmodule
