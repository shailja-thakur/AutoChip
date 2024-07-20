module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declarations
    typedef enum logic [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // State machine next state logic
    always_comb begin
        next_state = state; // Default stay in the same state
        done = 0;

        case (state)
            IDLE: begin
                if (in[3]) // Check if the fourth bit of the input is 1
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1;
            end
        endcase
    end

    // Sequential logic for capturing bytes
    always_ff @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
        end else begin
            case (next_state)
                BYTE1: byte1 <= in;
                BYTE2: byte2 <= in;
                BYTE3: byte3 <= in;
                IDLE: if (state == BYTE3) out_bytes <= {byte1, byte2, byte3};
            endcase
        end
    end

endmodule
