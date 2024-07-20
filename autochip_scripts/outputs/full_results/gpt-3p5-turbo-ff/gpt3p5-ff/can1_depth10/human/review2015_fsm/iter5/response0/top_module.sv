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
    reg [1:0] count;
    reg pattern_detected;
    reg prev_data; // To store previous data value
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initialize state to 0
            count <= 2'b00; // Initialize count to 0
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            pattern_detected <= 1'b0;
            prev_data <= 1'b0;
        end else begin
            prev_data <= data;
            case(state)
                3'b000: begin // State 0 - Searching for start sequence
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (prev_data && !data) begin
                        state <= 3'b001; // Go to state 1
                    end else begin
                        state <= 3'b000; // Stay in state 0
                    end
                end

                3'b001: begin // State 1 - Start sequence detected
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (prev_data && !data) begin
                        state <= 3'b010; // Go to state 2
                    end else begin
                        state <= 3'b000; // Go back to state 0
                    end
                end

                3'b010: begin // State 2 - Determining duration
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (!prev_data && data) begin
                        state <= 3'b011; // Go to state 3
                    end else begin
                        state <= 3'b000; // Go back to state 0
                    end
                end

                3'b011: begin // State 3 - Shift enable and start counting
                    shift_ena <= 1'b1;
                    counting <= 1'b1;
                    state <= 3'b100; // Go to state 4
                end

                3'b100: begin // State 4 - Waiting for counters to finish
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b0;
                    if (done_counting) begin
                        state <= 3'b101; // Go to state 5
                    end else begin
                        state <= 3'b100; // Stay in state 4
                    end
                end

                3'b101: begin // State 5 - Timer timed out
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= 3'b110; // Go to state 6
                end

                3'b110: begin // State 6 - Waiting for acknowledgment
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        state <= 3'b000; // Go back to state 0
                    end else begin
                        state <= 3'b110; // Stay in state 6
                    end
                end
            endcase
        end
    end
endmodule
