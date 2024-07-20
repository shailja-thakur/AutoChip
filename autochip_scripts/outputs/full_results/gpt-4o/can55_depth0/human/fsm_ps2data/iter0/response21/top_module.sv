module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // FSM states
    typedef enum reg [1:0] {
        IDLE = 2'b00,    // Idle state, waiting for the first byte with in[3] = 1
        BYTE1 = 2'b01,   // First byte of the message is captured
        BYTE2 = 2'b11,   // Second byte of the message is captured
        BYTE3 = 2'b10    // Third byte of the message is captured
    } state_t;

    state_t current_state, next_state;

    // Registers to hold the bytes
    reg [7:0] byte1, byte2, byte3;
    
    // State transition and output logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
                done = 1'b0;
            end
            BYTE1: begin
                next_state = BYTE2;
                done = 1'b0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 1'b0;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Byte capture logic
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'h00;
            byte2 <= 8'h00;
            byte3 <= 8'h00;
            out_bytes <= 24'h000000;
        end
        else begin
            case (next_state)
                BYTE1: begin
                    byte1 <= in;
                end
                BYTE2: begin
                    byte2 <= in;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, in};
                end
            endcase
        end
    end
endmodule
