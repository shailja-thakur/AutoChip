module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (data == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b001;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    if (data == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b010;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b010: begin
                    if (data == 1'b0) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b011;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b011: begin
                    if (data == 1'b1) begin
                        shift_ena <= 1;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b100;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b100: begin
                    if (data == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 1;
                        done <= 0;
                        state <= 3'b101;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b101: begin
                    if (data == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b110;
                    end else if (done_counting == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                        state <= 3'b111;
                    end else begin
                        shift_ena <= 0;
                        counting <= 1;
                        done <= 0;
                        state <= 3'b101;
                    end
                end
                3'b110: begin
                    if (data == 1'b0) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b011;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end
                end
                3'b111: begin
                    if (ack == 1'b1) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= 3'b000;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                        state <= 3'b111;
                    end
                end
            endcase
        end
    end

endmodule
