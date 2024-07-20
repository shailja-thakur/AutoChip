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
    reg start_detected;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initialize state to 0
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            start_detected <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // State 0 - Searching for start sequence
                    if (data == 1'b1) begin
                        state <= 3'b001; // Go to state 1
                    end else begin
                        state <= 3'b000; // Stay in state 0
                    end
                end
                
                3'b001: begin // State 1 - Start sequence detected
                    if (data == 1'b1) begin
                        state <= 3'b010; // Go to state 2
                    end else begin
                        state <= 3'b000; // Go back to state 0
                    end
                end
                
                3'b010: begin // State 2 - Determining duration
                    if (data == 1'b0) begin
                        state <= 3'b011; // Go to state 3
                    end else begin
                        state <= 3'b000; // Go back to state 0
                    end
                end
                
                3'b011: begin // State 3 - Shift enable and start counting
                    state <= 3'b100; // Go to state 4
                    shift_ena <= 1'b1;
                    counting <= 1'b1;
                end
                
                3'b100: begin // State 4 - Waiting for counters to finish
                    if (done_counting) begin
                        state <= 3'b101; // Go to state 5
                    end else begin
                        state <= 3'b100; // Stay in state 4
                    end
                end
                
                3'b101: begin // State 5 - Timer timed out
                    state <= 3'b110; // Go to state 6
                    done <= 1'b1;
                end
                
                3'b110: begin // State 6 - Waiting for acknowledgment
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
