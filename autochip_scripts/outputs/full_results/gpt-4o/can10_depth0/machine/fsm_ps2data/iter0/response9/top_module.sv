module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    // State Encoding
    localparam BYTE1 = 2'b00, 
               BYTE2 = 2'b01, 
               BYTE3 = 2'b10, 
               DONE  = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Sequential logic for state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 0;
            out_bytes <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                shift_reg <= (shift_reg << 8) | in;
            end
            if (state == DONE) begin
                out_bytes <= shift_reg;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

endmodule
