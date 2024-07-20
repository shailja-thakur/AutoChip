module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;

    reg [2:0] bit_count;
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            bit_count <= 0;
            data_byte <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in == 0) // Start bit detected
                        next_state = START;
                    else
                        next_state = IDLE;
                end

                START: begin
                    next_state = DATA;
                    bit_count = 0;
                    data_byte = 8'b0;
                end

                DATA: begin
                    data_byte[bit_count] = in;
                    bit_count = bit_count + 1;
                    if (bit_count == 7)
                        next_state = STOP;
                    else
                        next_state = DATA;
                end

                STOP: begin
                    if (in == 1) begin // Stop bit should be 1
                        out_byte = data_byte;
                        done = 1;
                        next_state = IDLE;
                    end else begin
                        // If Stop bit is incorrect, move to ERROR state to wait for next stop bit
                        next_state = ERROR;
                    end
                end

                ERROR: begin
                    if (in == 1) begin // Stop bit detected
                        next_state = IDLE;
                    end else begin
                        next_state = ERROR;
                    end
                end
                
                default: next_state = IDLE;
            endcase
        end
    end
endmodule
