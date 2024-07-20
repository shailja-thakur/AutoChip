module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11} state_t;
    state_t state, next_state;

    reg [23:0] byte_reg;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        case (state)
            BYTE1: begin
                if (in[2]) // Check third bit of input
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2]) // Check third bit of input
                    next_state = BYTE1;
                else
                    next_state = BYTE1;
            end
            default: next_state = BYTE1;
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
            out_bytes <= 24'b0;
            byte_reg <= 24'b0;
        end else if (state == DONE) begin
            done <= 1'b1;
            out_bytes <= byte_reg;
        end else begin
            done <= 1'b0;
            byte_reg <= byte_reg << 8 | in;
        end
    end

endmodule
