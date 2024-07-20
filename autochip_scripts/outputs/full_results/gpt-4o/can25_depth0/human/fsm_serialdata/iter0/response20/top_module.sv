module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    typedef enum reg [2:0] {IDLE, START, DATA, STOP} state_t;
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            done <= 0;
            out_byte <= 8'd0;
            data_reg <= 8'd0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        bit_count = bit_count;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                if (in == 0) // Start bit confirmed
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            DATA: begin
                next_state = (bit_count == 3'd7) ? STOP : DATA;
            end
            STOP: begin
                if (in == 1) begin // Stop bit confirmed
                    done = 1;
                    next_state = IDLE;
                end else begin // Wait for stop bit
                    next_state = STOP;
                end
            end
        endcase

        // Update bit count and data register
        if (current_state == DATA) begin
            data_reg[bit_count] = in;
            bit_count = bit_count + 1;
        end else if (current_state == STOP) begin
            if (in == 1) begin // Stop bit confirmed
                out_byte = data_reg;
                bit_count = 0;
            end
        end else begin
            bit_count = 0;
        end
    end
endmodule
