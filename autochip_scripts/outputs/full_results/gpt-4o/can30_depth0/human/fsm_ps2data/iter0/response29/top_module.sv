module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// FSM state declarations
typedef enum reg [1:0] {
    WAIT_FOR_START = 2'b00,
    BYTE_1 = 2'b01,
    BYTE_2 = 2'b10,
    BYTE_3 = 2'b11
} state_t;

state_t current_state, next_state;
reg [23:0] byte_buffer;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= WAIT_FOR_START;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        WAIT_FOR_START: begin
            if (in[3])
                next_state = BYTE_1;
            else
                next_state = WAIT_FOR_START;
        end
        BYTE_1: next_state = BYTE_2;
        BYTE_2: next_state = BYTE_3;
        BYTE_3: next_state = WAIT_FOR_START;
        default: next_state = WAIT_FOR_START;
    endcase
end

// Output logic and buffer update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        done <= 0;
        out_bytes <= 24'dx;
        byte_buffer <= 24'dx;
    end else begin
        case (current_state)
            WAIT_FOR_START: begin
                done <= 0;
            end
            BYTE_1: begin
                byte_buffer[23:16] <= in;
                done <= 0;
            end
            BYTE_2: begin
                byte_buffer[15:8] <= in;
                done <= 0;
            end
            BYTE_3: begin
                byte_buffer[7:0] <= in;
                out_bytes <= byte_buffer;
                done <= 1;
            end
            default: begin
                done <= 0;
            end
        endcase
        // Latch the output for one clock cycle after done
        if (done)
            out_bytes <= byte_buffer;
        else
            out_bytes <= 24'dx;
    end
end

endmodule
