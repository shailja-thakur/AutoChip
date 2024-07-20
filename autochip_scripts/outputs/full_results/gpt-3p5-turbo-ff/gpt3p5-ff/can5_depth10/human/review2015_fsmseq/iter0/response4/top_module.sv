module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else begin
            case(state)
                4'b0000: begin
                    if (data == 1'b1)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                4'b0001: begin
                    if (data == 1'b1)
                        state <= 4'b0011;
                    else
                        state <= 4'b0000;
                end
                4'b0011: begin
                    if (data == 1'b0)
                        state <= 4'b0100;
                    else
                        state <= 4'b0000;
                end
                4'b0100: begin
                    if (data == 1'b1)
                        state <= 4'b0110;
                    else
                        state <= 4'b0000;
                end
                4'b0110: begin
                    if (data == 1'b1)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                default: state <= 4'b0000;
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 4'b0111)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end

endmodule
