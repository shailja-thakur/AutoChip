module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// Define states
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Define state register
reg [2:0] state;

// Define data register
reg [7:0] data;

// Define counter for data bits
reg [2:0] bit_counter;

// Define start bit detection signal
reg start_bit_detected;

// Define done signal
wire done;

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Assign next state based on current state and input signal
always_comb begin
    case (state)
        IDLE: begin
            if (in == 1'b0)
                next_state = START_BIT;
            else
                next_state = IDLE;
        end
        START_BIT: begin
            if (in == 1'b0) begin
                next_state = DATA_BITS;
                start_bit_detected = 1'b1;
                bit_counter = 3'b000;
            end
            else
                next_state = IDLE;
        end
        DATA_BITS: begin
            if (bit_counter == 3'b111) begin
                next_state = STOP_BIT;
                data[bit_counter] = in;
            end
            else begin
                next_state = DATA_BITS;
                data[bit_counter] = in;
                bit_counter = bit_counter + 3'b001;
            end
        end
        STOP_BIT: begin
            if (bit_counter == 3'b111 && in == 1'b1) begin
                next_state = IDLE;
                out_byte = data;
                done = 1'b1;
            end
            else begin
                next_state = STOP_BIT;
                done = 1'b0;
            end
        end
    endcase
end

endmodule
