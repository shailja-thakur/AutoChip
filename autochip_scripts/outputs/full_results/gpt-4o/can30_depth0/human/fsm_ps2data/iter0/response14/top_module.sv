module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define the states of the FSM
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    message[23:16] = in;
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                message[15:8] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                message[7:0] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                out_bytes = message;
                done = 1;
                if (in[3] == 1) begin
                    // Handle case where new message overlaps
                    message[23:16] = in;
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Output the message
    always @(posedge clk) begin
        if (done) begin
            out_bytes <= message;
        end
    end
endmodule
