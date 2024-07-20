module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    input wire ack,
    output wire [3:0] count,
    output reg counting,
    output reg done);
    
    reg [3:0] delay; // To store the timer delay
    reg [3:0] remaining_time; // To store the current remaining time
    
    reg [3:0] state; // To track the current state of the state machine
    
    reg [3:0] shift_reg; // Shift register to store the last 4 bits of data
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            count <= 4'b0;
            remaining_time <= 4'b0;
            shift_reg <= 4'b0;
            state <= 4'b0;
        end else begin
            if (state == 4'b0000) begin // Searching for input sequence 1101
                if (data == 1) begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the next bit of data
                    if (shift_reg == 4'b1101) begin
                        delay <= shift_reg; // Store the timer delay
                        state <= 4'b0001; // Transition to the next state
                    end
                end
            end else if (state == 4'b0001) begin // Counting state
                counting <= 1; // Assert counting output
                remaining_time <= delay; // Set the initial remaining time
                
                if (remaining_time == 4'b0) begin
                    counting <= 0;
                    done <= 1; // Timer has timed out
                    state <= 4'b0010; // Transition to the next state
                end else begin
                    remaining_time <= remaining_time - 1; // Decrement remaining time
                    
                    if (counting)
                        count <= remaining_time; // Output the current remaining time
                end
            end else if (state == 4'b0010) begin // Wait for ack state
                if (ack == 1) begin
                    counting <= 0;
                    done <= 0;
                    
                    count <= 4'b0;
                    remaining_time <= 4'b0;
                    shift_reg <= 4'b0;
                    
                    state <= 4'b0000; // Transition back to searching state
                end
            end
        end
    end
endmodule
