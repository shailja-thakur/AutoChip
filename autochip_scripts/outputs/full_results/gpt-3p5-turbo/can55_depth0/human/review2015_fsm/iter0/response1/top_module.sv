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
            state <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                // State 0: Searching for the start sequence (1101)
                4'b0000: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1'b1;
                        state <= 4'b0001;
                    end else begin
                        shift_ena <= 1'b0;
                        state <= 4'b0000;
                    end
                end
                // State 1: Shifting in 4 more bits to determine delay duration
                4'b0001: begin
                    shift_ena <= 1'b1;
                    state <= 4'b0010;
                end
                // State 2: Waiting for counters to finish counting
                4'b0010: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    if (done_counting) begin
                        state <= 4'b0011;
                    end
                end
                // State 3: Timer has timed out
                4'b0011: begin
                    done <= 1'b1;
                    counting <= 1'b0;
                    state <= 4'b0100;
                end
                // State 4: Wait for acknowledgement before resetting
                4'b0100: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= 4'b0000;
                    end
                end
            endcase
        end
    end
endmodule
