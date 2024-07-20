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

    always @(posedge clk) begin
        if(reset) begin
            state <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                4'b0000: begin
                    if(data == 1'b1)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                4'b0001: begin
                    if(data == 1'b1)
                        state <= 4'b0010;
                    else
                        state <= 4'b0000;
                end
                4'b0010: begin
                    if(data == 1'b0)
                        state <= 4'b0011;
                    else
                        state <= 4'b0000;
                end
                4'b0011: begin
                    if(data == 1'b1) begin
                        state <= 4'b0100;
                        shift_ena <= 1'b1;
                    end else
                        state <= 4'b0000;
                end
                4'b0100: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    if(done_counting) begin
                        state <= 4'b0101;
                        done <= 1'b1;
                    end
                end
                4'b0101: begin
                    if(ack) begin
                        state <= 4'b0000;
                        done <= 1'b0;
                    end
                end
                default: state <= 4'b0000;
            endcase
        end
    end
endmodule
