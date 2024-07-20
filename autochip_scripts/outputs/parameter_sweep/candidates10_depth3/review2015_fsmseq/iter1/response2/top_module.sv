module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg prev_data;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (prev_data == 1'b1 && data == 1'b1)
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (data == 1'b1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 1'b0)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data == 1'b1) begin
                        state <= 0;
                        start_shifting <= 1;
                    end else
                        state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        prev_data <= data;
    end
endmodule
