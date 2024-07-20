module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_count <= bit_count + 1;
                data_reg <= {in, data_reg[7:1]}; // Shift in the next data bit
            end else if (state == IDLE) begin
                bit_count <= 3'b000;
                data_reg <= 8'b00000000;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = (in == 1'b0) ? DATA : IDLE;
            end
            DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1;
                end else begin
                    next_state = WAIT_STOP;
                    done = 1'b0;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_byte <= 8'b00000000;
        end else if (state == STOP && in == 1'b1) begin
            out_byte <= data_reg;
        end else begin
            out_byte <= 8'b00000000;
        end
    end

endmodule
