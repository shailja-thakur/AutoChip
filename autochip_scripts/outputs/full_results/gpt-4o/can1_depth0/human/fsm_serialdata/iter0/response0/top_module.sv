module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // FSM state definitions
    typedef enum logic [2:0] {
        IDLE = 3'b000, 
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] bit_count; // to count the data bits received
    reg [7:0] data_buffer; // to store the received data bits
    
    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            data_buffer <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                data_buffer <= {in, data_buffer[7:1]};
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 4'd0;
            end
            if (state == STOP) begin
                out_byte <= data_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state; // default to stay in the current state
        case (state)
            IDLE: begin
                if (in == 1'b0) // detect start bit
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // confirm start bit
                    next_state = DATA;
                else
                    next_state = IDLE; // if it wasn't a valid start bit
            end
            DATA: begin
                if (bit_count == 4'd8) // all 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // verify stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR; // if stop bit is incorrect
            end
            ERROR: begin
                if (in == 1'b1) // wait for idle
                    next_state = IDLE;
            end
        endcase
    end
    
endmodule
