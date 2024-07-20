module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_register;
    reg [2:0] bit_count;

    // States encoding
    localparam IDLE       = 4'd0,
               START_BIT  = 4'd1,
               RECEIVE    = 4'd2,
               STOP_BIT   = 4'd3,
               DONE       = 4'd4;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state; // Default to maintain current state
        done = 1'b0; // Default to 0
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
            end

            START_BIT: begin
                if (in == 1'b0) // Ensuring start bit is still 0
                    next_state = RECEIVE;
            end

            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = DONE;
                end else begin
                    next_state = IDLE; // Error in stop bit, re-synchronize
                end
            end

            DONE: begin
                next_state = IDLE; // Return to idle after done is high for one cycle
            end

        endcase
    end

    // Bit counter and data register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            data_register <= 8'b0;
            out_byte <= 8'b0;
        end else if (state == RECEIVE) begin
            data_register[bit_count] <= in; // Shift in data bits
            bit_count <= bit_count + 1;
        end else if (next_state == DONE) begin
            out_byte <= data_register; // Latch the received byte into out_byte
            bit_count <= 3'd0; // Reset bit count
        end else if (state != RECEIVE) begin
            bit_count <= 3'd0; // Reset bit count if not in RECEIVE state
        end
    end

endmodule
