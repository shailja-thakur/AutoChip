module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[2] == 1'b0) ? BYTE1 : BYTE2;
            default: next_state = BYTE1;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else if (current_state == DONE) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end
endmodule
