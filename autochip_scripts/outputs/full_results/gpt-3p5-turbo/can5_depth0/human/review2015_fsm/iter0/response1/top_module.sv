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
            state <= 4'b0;
        end else begin
            case (state)
                4'b0000: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1'b1;
                        counting <= 1'b0;
                        state <= 4'b0001;
                    end else begin
                        shift_ena <= 1'b0;
                        counting <= 1'b0;
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    state <= 4'b0010;
                end
                4'b0010: begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    state <= 4'b0011;
                end
                4'b0011: begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    state <= 4'b0100;
                end
                4'b0100: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    if (done_counting) begin
                        state <= 4'b0101;
                    end else begin
                        state <= 4'b0100;
                    end
                end
                4'b0101: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        state <= 4'b0000;
                    end else begin
                        state <= 4'b0101;
                    end
                end
            endcase
        end
    end
endmodule
