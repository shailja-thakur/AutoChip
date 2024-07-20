module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] next_state;
    reg prev_data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            prev_data <= data;

            case (state)
                0: begin
                    if (prev_data & !data)
                        next_state <= 1;
                    else
                        next_state <= 0;
                end
                1: begin
                    if (prev_data & data)
                        next_state <= 2;
                    else
                        next_state <= 0;
                end
                2: begin
                    if (prev_data & data)
                        next_state <= 3;
                    else
                        next_state <= 0;
                end
                3: begin
                    if (prev_data & !data) begin
                        next_state <= 1;
                        start_shifting <= 1;
                    end else begin
                        next_state <= 0;
                        start_shifting <= 0;
                    end
                end
                default: next_state <= 0;
            endcase
        end
    end
endmodule
