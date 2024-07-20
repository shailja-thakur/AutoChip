module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define the states
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
        end else begin
            state <= next_state;
            if (next_state != DONE) begin
                shift_reg <= (shift_reg << 8) | in;
            end
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
                done = 1'b0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 1'b0;
            end
            BYTE3: begin
                next_state = DONE;
                done = 1'b0;
            end
            DONE: begin
                next_state = BYTE1;
                done = 1'b1;
            end
            default: begin
                next_state = BYTE1;
                done = 1'b0;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (next_state == DONE) begin
            out_bytes <= shift_reg;
        end
    end

endmodule
