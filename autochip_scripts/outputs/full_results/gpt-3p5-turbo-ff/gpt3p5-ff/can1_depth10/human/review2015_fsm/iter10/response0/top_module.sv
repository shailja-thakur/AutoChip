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
    reg [3:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initialize state to 0
            count <= 4'b0000; // Initialize count to 0
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // State 0 - Searching for start sequence
                    if (data == 4'b1101) begin
                        state <= 3'b001; // Go to state 1
                    end else begin
                        state <= 3'b000; // Stay in state 0
                    end
                end
                
                3'b001: begin // State 1 - Start sequence detected
                    state <= 3'b010; // Go to state 2
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    count <= 4'b0000;
                end
                
                3'b010: begin // State 2 - Determining duration
                    state <= 3'b011; // Go to state 3
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    count <= count + 1;
                end
                
                3'b011: begin // State 3 - Waiting for counters to finish
                    if (count == 4'b0100) begin
                        state <= 3'b100; // Go to state 4
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else if (done_counting) begin
                        state <= 3'b100; // Go to state 4
                    end else begin
                        state <= 3'b011; // Stay in state 3
                    end
                end
                
                3'b100: begin // State 4 - Wait for acknowledgment
                    if (ack) begin
                        state <= 3'b000; // Go back to state 0
                        done <= 1'b0;
                    end else begin
                        state <= 3'b100; // Stay in state 4
                    end
                end
            endcase
        end
    end
endmodule
