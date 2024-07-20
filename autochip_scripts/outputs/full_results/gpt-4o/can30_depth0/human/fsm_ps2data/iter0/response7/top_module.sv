module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] byte_buffer;
    reg [7:0] byte1, byte2, byte3;

    // State encoding
    localparam [1:0] 
        IDLE    = 2'b00,
        BYTE1   = 2'b01,
        BYTE2   = 2'b10,
        BYTE3   = 2'b11;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_buffer <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (done) begin
                out_bytes <= byte_buffer;
            end
        end
    end

    // Next state logic
    always @(*) begin
        done = 0;
        next_state = state; // Default to stay in the same state
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                    byte1 = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                byte2 = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                byte3 = in;
            end
            BYTE3: begin
                next_state = IDLE;
                byte_buffer = {byte1, byte2, byte3};
                done = 1;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output assignment
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (done) begin
            out_bytes <= {byte1, byte2, byte3};
        end
    end

endmodule
