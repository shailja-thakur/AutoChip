module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // FSM states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] temp_bytes;

    // State update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Output and next state logic
    always @(*) begin
        // Default values
        done = 1'b0;
        next_state = state;
        out_bytes = 24'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                temp_bytes[23:16] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                temp_bytes[15:8] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                temp_bytes[7:0] = in;
                done = 1'b1;
                next_state = IDLE; // Go back to IDLE state after completing the message
                out_bytes = temp_bytes;
            end
        endcase
    end

    // Register to store the temporary bytes
    always @(posedge clk) begin
        if (reset) begin
            temp_bytes <= 24'b0;
        end else if (state == BYTE1 || state == BYTE2 || state == BYTE3) begin
            temp_bytes <= temp_bytes;
        end
    end
endmodule
