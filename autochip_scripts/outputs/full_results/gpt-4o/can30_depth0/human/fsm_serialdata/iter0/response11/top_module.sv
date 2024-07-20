module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    reg [3:0] state, next_state;
    reg [7:0] data_byte;
    reg [2:0] bit_count;

    // State encoding
    localparam IDLE = 4'd0, START = 4'd1, DATA = 4'd2, STOP = 4'd3, DONE = 4'd4, ERROR = 4'd5;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        next_state = state; // Default to hold state
        done = 1'b0;        // Default done to 0
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_count = 3'd0;
            end
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
                bit_count = bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = DONE;
                else
                    next_state = ERROR;
            end
            DONE: begin
                done = 1'b1;
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1) // Wait for the line to go back to idle (stop bit)                
                    next_state = IDLE;
            end
        endcase
    end

    // Data byte capturing
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_byte <= 8'd0;
        else if (state == DATA)
            data_byte[bit_count] <= in;
    end

    // Output the byte
    always @(posedge clk) begin
        if (state == DONE)
            out_byte <= data_byte;
    end

endmodule
