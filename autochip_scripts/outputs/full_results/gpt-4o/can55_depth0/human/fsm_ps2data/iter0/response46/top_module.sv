module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] byte_buffer;

    // State encoding
    localparam WAIT = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        done = 0;
        next_state = state;  // Default to the current state

        case (state)
            WAIT: begin
                if (in[3] == 1'b1) begin
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
                next_state = WAIT;
                done = 1;
            end
        endcase
    end

    // Byte buffer logic
    always @(posedge clk) begin
        if (reset) begin
            byte_buffer <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            case (next_state)
                BYTE1: byte_buffer[23:16] <= in;
                BYTE2: byte_buffer[15:8] <= in;
                BYTE3: byte_buffer[7:0] <= in;
                WAIT: begin
                    if (state == BYTE3) out_bytes <= byte_buffer;
                    else out_bytes <= 24'b0;
                end
            endcase
        end
    end

    // Output done signal when the state machine is in WAIT state after receiving 3 bytes
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (state == BYTE3 && next_state == WAIT) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end
endmodule
