module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic[2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [7:0] data_shift;
    reg [3:0] bit_counter;  // counts from 0 to 9 (total 10 bits: 1 start + 8 data + 1 stop)

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Next state logic and output generation
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next_state <= IDLE;
            data_shift <= 8'b0;
            bit_counter <= 4'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0)  // detect start bit
                        next_state <= START_BIT;
                    else
                        next_state <= IDLE;
                end
                START_BIT: begin
                    if (bit_counter < 4'b0001) begin
                        bit_counter <= bit_counter + 4'b0001;
                        next_state <= START_BIT;
                    end else begin
                        bit_counter <= 4'b0000;
                        next_state <= DATA_BITS;
                    end
                end
                DATA_BITS: begin
                    data_shift <= {in, data_shift[7:1]};
                    if (bit_counter < 8) begin
                        bit_counter <= bit_counter + 4'b0001;
                        next_state <= DATA_BITS;
                    end else begin
                        bit_counter <= 4'b0000;
                        next_state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin  // verify stop bit
                        done <= 1'b1;
                        next_state <= DONE;
                    end else
                        next_state <= IDLE;  // wait for the next start bit
                end
                DONE: begin
                    done <= 1'b0;
                    if (in == 1'b1)
                        next_state <= IDLE;
                    else
                        next_state <= START_BIT;
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule
