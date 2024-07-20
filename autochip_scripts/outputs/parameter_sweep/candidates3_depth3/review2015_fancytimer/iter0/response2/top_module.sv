module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

// Internal signals
reg [3:0] delay;
reg [3:0] remaining_time;
reg [1:0] state;
reg [3:0] shift_reg;
wire start_sequence_detected;
wire counting_done;

// Counter for counting clock cycles
reg [9:0] counter;

// Detect start sequence 1101
assign start_sequence_detected = (shift_reg == 4'hD);

// Update shift register when not counting
always @(posedge clk) begin
    if (!counting) begin
        shift_reg[3:0] <= {shift_reg[2:0], data};
    end
end

// Update state machine and delay value
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        delay <= 4'b0;
    end else begin
        case (state)
            2'b00: begin // Idle state, look for start sequence
                if (start_sequence_detected) begin
                    state <= 2'b01; // Start sequence detected, move to next state
                    delay <= shift_reg[3:0]; // Update delay value
                end
            end
            2'b01: begin // Start counting state
                state <= 2'b10; // Move to next state
                counting <= 1'b1; // Start counting
                counter <= 0; // Reset counter
            end
            2'b10: begin // Counting state
                if (counter < (delay + 1) * 1000) begin // Check if delay time has passed
                    counter <= counter + 1; // Increment counter
                end else begin
                    state <= 2'b11; // Time is up, move to next state
                    done <= 1'b1; // Notify user timer is done
                end
            end
            2'b11: begin // Waiting for acknowledgement state
                if (ack) begin // Acknowledgment received, reset state machine
                    state <= 2'b00; // Move to start state
                    counting <= 1'b0; // Stop counting
                    done <= 1'b0; // Reset done signal
                end
            end
        endcase
    end
end

// Update remaining time based on state and counter value
always @(posedge clk) begin
    if (reset) begin
        remaining_time <= 4'b0;
    end else begin
        case (state)
            2'b10: begin // Counting state
                if (counter >= (delay + 1) * 1000 - 1000) begin // Check if remaining time needs to be updated
                    remaining_time <= delay; // Update remaining time
                end
            end
            2'b11: begin // Waiting for acknowledgement state
                remaining_time <= 4'b0; // Reset remaining time
            end
            default: begin
                remaining_time <= remaining_time; // Keep remaining time unchanged
            end
        endcase
    end
end

// Assign output signals
assign count = counting ? remaining_time : 4'bXXXX; // Don't care when not counting
assign counting_done = (counter >= (delay + 1) * 1000);

endmodule
