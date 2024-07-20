module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg reset_sync;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
            reset_sync <= 1'b1;
        end else begin
            reset_sync <= 1'b0;
            case(state)
                4'b0000: begin
                    if (data) state <= 4'b0001;
                end
                4'b0001: begin
                    if (data) state <= 4'b0011;
                    else state <= 4'b0000;
                end
                4'b0011: begin
                    if (data) state <= 4'b0110;
                    else state <= 4'b0000;
                end
                4'b0110: begin
                    if (data) state <= 4'b1101;
                    else state <= 4'b0000;
                end
                4'b1101: begin
                    start_shifting <= 1'b1;
                    state <= 4'b1101;
                end
                default: state <= 4'b0000;
            endcase
        end
    end
endmodule
