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
            prev_data <= data;
            case (state)
                0: begin
                    if (prev_data & !data)
                        state <= 1;
                end
                1: begin
                    if (prev_data & data)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (prev_data & data)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (prev_data & !data) begin
                        state <= 1;
                        start_shifting <= 1;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
endmodule
