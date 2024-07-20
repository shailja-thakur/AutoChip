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
                4'b0000: begin // Idle state
                    if (data == 4'b1101)
                        state <= 4'b0001;
                    else
                        state <= 4'b0000;
                end
                4'b0001: begin // Shift enable state
                    state <= 4'b0010;
                    shift_ena <= 1; // Assert shift_ena for 4 clock cycles
                end
                4'b0010: begin // Counting state
                    if (done_counting)
                        state <= 4'b0011;
                    else
                        state <= 4'b0010;
                end
                4'b0011: begin // Done state
                    state <= 4'b0100;
                    done <= 1; // Notify the user timer has timed out
                end
                4'b0100: begin // Wait for acknowledgement state
                    if (ack)
                        state <= 4'b0000; // Reset to look for the next start sequence
                    else
                        state <= 4'b0100;
                end
            endcase
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            counting <= 0;
        else begin
            if (state != 4'b0000 && state != 4'b0010)
                counting <= 1; // Assert counting to indicate waiting for counters
            else
                counting <= 0;
        end
    end

endmodule
