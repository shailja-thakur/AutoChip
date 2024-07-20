module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        RESET       = 2'b00,
        FIND_START  = 2'b01,
        BYTE_2      = 2'b10,
        BYTE_3      = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message;
    reg [7:0] byte1, byte2, byte3;

    // State register update
    always_ff @(posedge clk) begin
        if (reset)
            state <= RESET;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        done = 1'b0;
        next_state = state;  // Default to no state change
        case (state)
            RESET: begin
                out_bytes = 24'b0;
                message = 24'b0;
                if (!reset)
                    next_state = FIND_START;
            end
            FIND_START: begin
                if (in[3] == 1'b1) begin
                    byte1 = in;
                    next_state = BYTE_2;
                end
            end
            BYTE_2: begin
                byte2 = in;
                next_state = BYTE_3;
            end
            BYTE_3: begin
                byte3 = in;
                message = {byte1, byte2, byte3};
                out_bytes = message;
                done = 1'b1;
                next_state = FIND_START;
            end
        endcase
    end

endmodule
