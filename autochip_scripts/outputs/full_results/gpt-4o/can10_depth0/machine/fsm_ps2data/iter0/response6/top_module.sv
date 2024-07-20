module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definitions
    typedef enum reg {BYTE1, BYTE2, BYTE3, DONE} state_t;
    state_t current_state, next_state;

    // 24-bit register to store the output
    reg [23:0] shift_register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_register <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            current_state <= next_state;

            if (current_state == BYTE1 || current_state == BYTE2 || current_state == BYTE3) begin
                shift_register <= {shift_register[15:0], in}; // Shift left by 8 bits and input new byte
            end
            
            if (current_state == DONE) begin
                out_bytes <= shift_register;
            end
        end
    end

    always @(*) begin
        // Default values
        next_state = current_state;
        done = 0;

        case (current_state)
            BYTE1: begin
                if (in[2] == 1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (in[2] == 0) begin
                    next_state = BYTE1;
                end
            end
        endcase
    end

endmodule
