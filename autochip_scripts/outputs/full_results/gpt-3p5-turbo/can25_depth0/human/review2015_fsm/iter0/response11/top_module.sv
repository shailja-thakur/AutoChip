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
        if (reset)
            state <= 4'b0000;
        else begin
            case (state)
                4'b0000: begin
                    if (data == 4'b1101)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                4'b0001: begin
                    shift_ena <= 1;
                    state <= 4'b0010;
                end
                4'b0010: begin
                    shift_ena <= 0;
                    counting <= 1;
                    state <= 4'b0011;
                end
                4'b0011: begin
                    if (done_counting)
                        state <= 4'b0100;
                    else
                        state <= 4'b0011;
                end
                4'b0100: begin
                    done <= 1;
                    if (ack)
                        state <= 4'b0000;
                    else
                        state <= 4'b0100;
                end
            endcase
        end
    end

endmodule
