module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// State Definition
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Registers
reg [2:0] state;
reg [7:0] shift_register;
reg start_bit_detected;

// Next-State and Output Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_register <= 8'b0;
        start_bit_detected <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE:
                if (in == 1'b0)
                    state <= START_BIT;
            START_BIT:
                if (in == 1'b0)
                    state <= DATA_BITS;
                else
                    state <= IDLE;
            DATA_BITS:
                if (in == 1'b1)
                    state <= STOP_BIT;
                else
                    shift_register <= {shift_register[6:0], in};
            STOP_BIT:
                if (in == 1'b1) begin
                    out_byte <= shift_register;
                    shift_register <= 8'b0;
                    start_bit_detected <= 1'b0;
                    done <= 1'b1;
                    state <= START_BIT;
                end
                else
                    state <= IDLE;
        endcase
    end
end

endmodule
