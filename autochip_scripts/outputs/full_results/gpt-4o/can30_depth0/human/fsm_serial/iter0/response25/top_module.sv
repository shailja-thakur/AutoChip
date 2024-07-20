module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [3:0] bit_counter;

    // State Encoding
    localparam IDLE    = 4'd0,
               START   = 4'd1,
               DATA    = 4'd2,
               STOP    = 4'd3,
               WAIT_STOP = 4'd4;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 4'd0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_counter <= bit_counter + 4'd1;
                data[bit_counter] <= in;
            end else if (state != DATA) begin
                bit_counter <= 4'd0;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0)  // Detect the start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                done = 1'b0;
                if (bit_counter == 4'd0)  // Successfully detected the start bit and moved to first data bit
                    next_state = DATA;
                else
                    next_state = START;
            end
            DATA: begin
                done = 1'b0;
                if (bit_counter == 4'd7)  // All 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin  // Stop bit is correct
                    done = 1'b1;
                    next_state = IDLE;
                end else begin  // Stop bit is incorrect, wait until it finds a stop bit
                    done = 1'b0;
                    next_state = WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                done = 1'b0;
                if (in == 1'b1)  // Find another stop bit
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            default: begin
                done = 1'b0;
                next_state = IDLE;
            end
        endcase
    end
endmodule
