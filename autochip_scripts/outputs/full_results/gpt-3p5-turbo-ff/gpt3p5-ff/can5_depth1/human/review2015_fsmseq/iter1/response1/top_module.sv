module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg reset_sync;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
            reset_sync <= 1;
        end else if (reset_sync) begin
            state <= 0;
            start_shifting <= 0;
            reset_sync <= 0;
        end else begin
            case(state)
                0: begin
                    if (data == 1)
                        state <= 1;
                end
                1: begin
                    if (data == 1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 0)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data == 1) begin
                        state <= 4;
                        start_shifting <= 1;
                    end else
                        state <= 0;
                end
                4: begin
                    state <= 4;
                    start_shifting <= 1;
                end
                default: state <= 0;
            endcase
        end
    end

endmodule
