module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state; // State variables
    reg [1:0] byte_count; // Counter for bytes in the message

    // State Definitions
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // Synchronous state transition with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == IDLE && in[3])
                byte_count <= 2'b01; // Start counting at byte 1
            else if (state == BYTE1 || state == BYTE2)
                byte_count <= byte_count + 1;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == BYTE3) begin
            done = 1;
        end else begin
            done = 0;
        end
    end

endmodule
