module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // Reset state
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                2'b00: begin // Searching for start sequence
                    if (data == 4'b1101) begin
                        state <= 2'b01; // Found start sequence, go to delay setting state
                        delay <= 4'b0000;
                    end
                end
                2'b01: begin // Setting delay
                    if (data != 4'b1101) begin
                        delay <= data; // Shift in delay value
                        state <= 2'b10; // Go to counting state
                        counting <= 1;
                    end
                end
                2'b10: begin // Counting
                    if (count == (delay + 1)) begin
                        counting <= 0; // Finished counting
                        done <= 1; // Notify user
                        state <= 2'b11; // Go to wait for ack state
                    end
                end
                2'b11: begin // Waiting for ack
                    if (ack == 1) begin
                        done <= 0; // Reset done signal
                        state <= 2'b00; // Go back to searching for start sequence
                    end
                end
            endcase
        end
    end
    
    always@(posedge clk) begin
        if(counting) begin
            count <= delay - count; // Decrement count by 1 every 1000 cycles
        end else begin
            count <= 0; // Count output is don't care when not counting
        end
    end

endmodule
