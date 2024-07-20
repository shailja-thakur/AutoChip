module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @ (*) begin
        done = 1'b0; // Default value of done signal
        case (current_state)
            BYTE1: begin
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1; // Assert done signal
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end

endmodule
