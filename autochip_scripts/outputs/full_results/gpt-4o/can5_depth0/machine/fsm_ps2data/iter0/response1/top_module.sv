module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};
            end else if (current_state == DONE) begin
                out_bytes <= shift_reg;
                done <= 1;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
                done = 0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 0;
            end
            BYTE3: begin
                next_state = DONE;
                done = 0;
            end
            DONE: begin
                if (in[2]) begin
                    next_state = DONE;
                end else begin
                    next_state = BYTE1;
                end
                done = 1;
            end
            default: begin
                next_state = BYTE1;
                done = 0;
            end
        endcase
    end
endmodule
