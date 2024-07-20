module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1;
                        counting <= 0;
                        state <= 2'b01;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1;
                        counting <= 0;
                        state <= 2'b01;
                    end else if (done_counting) begin
                        shift_ena <= 0;
                        counting <= 1;
                        state <= 2'b10;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        state <= 2'b01;
                    end
                end
                2'b10: begin
                    if (ack) begin
                        done <= 1;
                        shift_ena <= 0;
                        counting <= 0;
                        state <= 2'b00;
                    end else begin
                        done <= 0;
                        shift_ena <= 0;
                        counting <= 0;
                        state <= 2'b10;
                    end
                end
                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    state <= 2'b00;
                end
            endcase
        end
    end
endmodule
