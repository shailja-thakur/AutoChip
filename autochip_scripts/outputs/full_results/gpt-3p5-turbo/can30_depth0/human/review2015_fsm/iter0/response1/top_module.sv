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
            state <= 4'b0000; // initial state
        end else begin
            case (state)
                4'b0000: begin // searching for start sequence
                    if (data == 4'b1101) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin // asserting shift_ena for 4 clock cycles
                    shift_ena <= 1;
                    counting <= 0;
                    state <= 4'b0010;
                end
                4'b0010: begin // waiting for counters to finish counting
                    shift_ena <= 0;
                    counting <= 1;
                    if (done_counting) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0010;
                    end
                end
                4'b0011: begin // timer timed out
                    done <= 1;
                    counting <= 0;
                    if (ack) begin
                        state <= 4'b0000;
                        done <= 0;
                    end else begin
                        state <= 4'b0011;
                    end
                end
            endcase
        end
    end
endmodule
