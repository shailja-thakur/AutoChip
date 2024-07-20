module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define the states for the FSM
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_type;

// Declare internal signals
reg [2:0] state;
reg [7:0] byte;
reg [2:0] bit_counter;
reg start_bit_detected;
reg stop_bit_detected;
reg [7:0] out_byte_reg;
reg done_reg;

// FSM process
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        byte <= 8'b0;
        bit_counter <= 3'b0;
        start_bit_detected <= 1'b0;
        stop_bit_detected <= 1'b0;
        out_byte_reg <= 8'b0;
        done_reg <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    start_bit_detected <= 1'b1;
                    bit_counter <= 3'b0;
                    byte <= 8'b0;
                end
            end
            START_BIT: begin
                if (bit_counter == 3'b0) begin
                    if (in == 1'b0) begin
                        bit_counter <= bit_counter + 3'b1;
                    end
                end else begin
                    state <= DATA_BITS;
                end
            end
            DATA_BITS: begin
                if (bit_counter < 3'b8) begin
                    byte[bit_counter] <= in;
                    bit_counter <= bit_counter + 3'b1;
                end else begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (bit_counter == 3'b8) begin
                    if (in == 1'b1) begin
                        stop_bit_detected <= 1'b1;
                        out_byte_reg <= byte;
                        done_reg <= 1'b1;
                    end
                end
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

// Assign outputs
assign out_byte = out_byte_reg;
assign done = done_reg;

endmodule
