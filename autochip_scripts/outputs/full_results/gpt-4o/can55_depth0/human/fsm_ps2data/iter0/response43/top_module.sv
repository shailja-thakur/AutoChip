module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0; // Default to 0
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

    // Output and shift register logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            shift_reg <= 24'b0;
        end else begin
            if (state == BYTE1) begin
                shift_reg[23:16] <= in;
            end else if (state == BYTE2) begin
                shift_reg[15:8] <= in;
            end else if (state == BYTE3) begin
                shift_reg[7:0] <= in;
                out_bytes <= {shift_reg[23:8], in}; // Combine with the current input byte
            end
        end
    end

endmodule
