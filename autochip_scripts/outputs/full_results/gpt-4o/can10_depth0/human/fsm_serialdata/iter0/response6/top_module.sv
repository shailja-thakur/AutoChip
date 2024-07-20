module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State declarations
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // Counter for the 8 data bits
    reg [7:0] data_buffer; // Buffer to hold received data bits

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    done <= 0;
                    data_buffer <= 8'b0;
                end
                START: begin
                    if (in == 1'b0) begin
                        bit_count <= 0;
                    end else begin
                        state <= IDLE; // Go back to IDLE state if start bit is not 0
                    end
                end
                DATA: begin
                    data_buffer[bit_count] <= in;
                    if (bit_count == 3'b111) begin
                        out_byte <= {in, data_buffer[7:1]};
                    end
                    bit_count <= bit_count + 1;
                end
                STOP: done <= 1;
                ERROR: begin
                    done <= 0;
                    data_buffer <= 8'b0;
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (in == 1'b0) next_state = START;
            START: if (in == 1'b0) next_state = DATA;
            DATA: if (bit_count == 3'b111) next_state = STOP;
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: if (in == 1'b1) next_state = IDLE;
        endcase
    end

endmodule
