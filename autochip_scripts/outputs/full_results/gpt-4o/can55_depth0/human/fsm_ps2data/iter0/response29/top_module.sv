module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definitions
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Registers to hold byte values
    reg [7:0] byte1, byte2, byte3;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // State machine next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                    byte1 = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                byte2 = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                byte3 = in;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
                out_bytes = {byte1, byte2, byte3};
            end
        endcase
    end

    // Output message when done is asserted
    always_ff @(posedge clk) begin
        if (done) begin
            out_bytes <= {byte1, byte2, byte3};
        end
    end
endmodule
