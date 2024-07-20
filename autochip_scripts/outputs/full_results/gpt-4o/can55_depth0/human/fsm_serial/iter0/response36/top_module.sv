module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            START: begin
                if (in == 0) // Still in start bit
                    next_state = DATA;
                else
                    next_state = IDLE; // Return to IDLE if still 1
            end
            DATA: begin
                if (bit_count == 3'd7) 
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1) // Stop bit should be 1
                    next_state = IDLE;
                else
                    next_state = ERROR; // Stop bit not correct
            end
            ERROR: begin
                if (in == 1) // Waiting for a valid stop bit to transition back to IDLE
                    next_state = IDLE;
            end
        endcase     
    end

    // Output Logic and Data Count/Collect
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            done <= 1'b0;
        end else case (current_state)
            IDLE: begin
                bit_count <= 3'd0;
                done <= 1'b0;
            end
            START: 
                bit_count <= 3'd0;
            DATA: begin
                data_byte[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            STOP: begin
                done <= 1'b1;
            end
            ERROR: begin
                bit_count <= 3'd0;
                done <= 1'b0;
            end
        endcase
    end

endmodule
