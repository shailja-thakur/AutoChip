module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// State definition
typedef enum logic [2:0] {
    IDLE,
    BYTE_1,
    BYTE_2,
    BYTE_3
} state_t;

// Internal signals
reg [2:0] state;
reg done;

// State initialization
initial begin
    state <= IDLE;
    done <= 0;
end

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    state <= BYTE_1;
                    done <= 0;
                end
            end
            BYTE_1: begin
                state <= BYTE_2;
            end
            BYTE_2: begin
                state <= BYTE_3;
            end
            BYTE_3: begin
                state <= IDLE;
                done <= 1;
            end
        endcase
    end
end

endmodule
