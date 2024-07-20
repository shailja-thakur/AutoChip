module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // state declarations
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] shift_reg;

    // state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            current_state <= next_state;

            // update shift_reg and out_bytes
            if (current_state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};  // Shift left 8 bits and load new input
            end 

            if (current_state == DONE) begin
                out_bytes <= shift_reg;
            end
        end
    end

    // next state logic
    always @(*) begin
        case (current_state)
            BYTE1: if (in[2]) next_state = BYTE2;
                   else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[2]) next_state = BYTE1;
                   else next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // done signal logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (current_state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
