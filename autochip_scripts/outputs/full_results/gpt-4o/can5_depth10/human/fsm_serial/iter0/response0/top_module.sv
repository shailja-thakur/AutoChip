module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [2:0] bit_counter;

    // State Encoding
    localparam IDLE      = 4'd0;
    localparam START     = 4'd1;
    localparam DATA_BITS = 4'd2;
    localparam STOP      = 4'd3;
    localparam WAIT_STOP = 4'd4;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b0;
        end
        else
            state <= next_state;
    end
    
    // Next State Logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA_BITS;
                bit_counter = 3'b0;
            end
            DATA_BITS: begin
                if (bit_counter < 3'd7) begin
                    next_state = DATA_BITS;
                    bit_counter = bit_counter + 1'b1;
                end
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Detect stop bit
                    next_state = IDLE;
                    done = 1'b1;
                end
                else
                    next_state = WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1'b1) // Wait until we see a stop bit (line idle)
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            default: next_state = IDLE;
        endcase
    end

    // Capture Data on Data State
    always @(posedge clk) begin
        if (state == DATA_BITS) begin
            data = {in, data[7:1]}; // Shift in the received data bits
        end
    end
endmodule
