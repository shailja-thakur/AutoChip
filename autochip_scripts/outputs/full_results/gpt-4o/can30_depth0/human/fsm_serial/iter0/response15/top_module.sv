module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [2:0] bit_count;

    localparam IDLE = 4'd0,
               START = 4'd1,
               DATA = 4'd2,
               STOP = 4'd3,
               ERROR = 4'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START;
            end
            START: begin
                // Move to DATA state to start reading bytes
                next_state = DATA;
            end
            DATA: begin
                // If all bits have been read, move to STOP state
                if (bit_count == 3'd7)
                    next_state = STOP;
                // Otherwise, stay in DATA state to read more bits.
            end
            STOP: begin
                if (in == 1)
                    next_state = IDLE; // Correct stop bit
                else
                    next_state = ERROR; // Incorrect stop bit
            end
            ERROR: begin
                if (in == 1)
                    next_state = IDLE; // Move to IDLE when line goes high
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'b0;
            bit_count <= 3'd0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    bit_count <= 3'd0; // Reset bit counter
                end
                START: begin
                    // Start reading data bits
                end
                DATA: begin
                    data[bit_count] <= in; // Store the data bits
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    done <= in; // Signal done if stop bit is correct
                end
                ERROR: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
