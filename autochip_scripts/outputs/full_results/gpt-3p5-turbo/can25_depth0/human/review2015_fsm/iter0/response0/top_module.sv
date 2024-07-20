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
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                4'b0000: begin // Idle state
                    if (data == 4'b1101) begin
                        state <= 4'b0001; // Start state
                        shift_ena <= 1;
                    end else begin
                        state <= 4'b0000;
                        shift_ena <= 0;
                    end
                    counting <= 0;
                    done <= 0;
                end
                
                4'b0001: begin // Start state
                    state <= 4'b0010; // Shift state
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end
                
                4'b0010: begin // Shift state
                    state <= 4'b0011; // Wait state
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end
                
                4'b0011: begin // Wait state
                    if (done_counting) begin
                        state <= 4'b0100; // Done state
                        shift_ena <= 0;
                        counting <= 1;
                        done <= 0;
                    end else begin
                        state <= 4'b0011;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
                
                4'b0100: begin // Done state
                    if (ack) begin
                        state <= 4'b0000; // Idle state
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        state <= 4'b0100;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule
