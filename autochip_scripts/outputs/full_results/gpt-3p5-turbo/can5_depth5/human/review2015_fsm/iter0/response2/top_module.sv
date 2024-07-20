module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            done <= 0;
            counting <= 0;
            shift_ena <= 0;
        end else begin
            case(state)
                4'b0000: begin
                    if (data == 1'b1)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                4'b0001: begin
                    if (data == 1'b1)
                        state <= 4'b0010;
                    else
                        state <= 4'b0000;
                end
                4'b0010: begin
                    if (data == 1'b0)
                        state <= 4'b0011;
                    else
                        state <= 4'b0000;
                end
                4'b0011: begin
                    if (data == 1'b1) begin
                        state <= 4'b0100;
                        shift_ena <= 1'b1;
                    end else
                        state <= 4'b0000;
                end
                4'b0100: begin
                    if (shift_ena) begin
                        state <= 4'b0101;
                        shift_ena <= 0;
                    end else
                        state <= 4'b0000;
                end
                4'b0101: begin
                    if (shift_ena) begin
                        state <= 4'b0110;
                        shift_ena <= 0;
                        counting <= 1'b1;
                    end else
                        state <= 4'b0000;
                end
                4'b0110: begin
                    if (done_counting)
                        state <= 4'b0111;
                    else
                        state <= 4'b0110;
                end
                4'b0111: begin
                    if (ack) begin
                        state <= 4'b0000;
                        done <= 1'b1;
                    end else
                        state <= 4'b0111;
                end
                default: state <= 4'b0000;
            endcase
        end
    end
endmodule
