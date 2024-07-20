module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// Define the states
localparam [2:0] WAIT_START = 3'd0,
                 WAIT_DELAY = 3'd1,
                 COUNTING   = 3'd2,
                 DONE       = 3'd3;

reg [2:0] state;
reg [3:0] delay;
reg [3:0] counter;

// State machine
always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Wait for the start sequence (1101)
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    // Shift in the delay value
                    delay <= {data, data, data, data};
                    state <= WAIT_DELAY;
                end
            end
            WAIT_DELAY: begin
                // Shift in the delay value
                delay <= {data, delay[3:1]};
                if (delay == 4'b0) begin
                    // Delay value has been shifted in
                    state <= COUNTING;
                    counting <= 1'b1;
                    counter <= delay + 1;
                end
            end
            COUNTING: begin
                // Decrement the counter
                if (counter == 4'b0) begin
                    // Timer has finished counting
                    state <= DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            DONE: begin
                // Wait for the user to acknowledge the timer
                if (ack == 1'b1) begin
                    // Reset the state machine
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? counter : 4'b0;

endmodule
