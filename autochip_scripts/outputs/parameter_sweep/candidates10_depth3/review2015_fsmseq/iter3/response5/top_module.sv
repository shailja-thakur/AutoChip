module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (data)
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (data)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (!data)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data)
                        state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 3)
            start_shifting <= 1;
        else if (reset)
            start_shifting <= 0;
    end

endmodule
