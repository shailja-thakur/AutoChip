module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE      = 3'd0,
        START     = 3'd1,
        RECEIVING = 3'd2,
        STOP      = 3'd3,
        ERROR     = 3'd4
    } state_t;
    state_t current_state, next_state;
    
    reg [2:0] bit_count;
    reg [7:0] data_buffer;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            data_buffer <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 3'd1;
            end
            else if (current_state == STOP) begin
                out_byte <= data_buffer;
            end
            done <= (current_state == STOP);
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVING;
            end
            RECEIVING: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                if (in == 1'b1)
                    next_state = ERROR; // Error state because stop bit was expected but received a 1
            end
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR; // Error because expected stop bit 1 was not found
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
