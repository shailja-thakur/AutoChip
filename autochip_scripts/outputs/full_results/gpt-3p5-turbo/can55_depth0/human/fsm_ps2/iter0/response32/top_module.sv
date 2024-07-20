module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define the states
typedef enum logic [2:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
} state_t;

// Define the signals
reg done;
reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

// Define the state register and next state logic
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= BYTE1;
                end
            end
            BYTE1: begin
                byte2 <= in;
                state <= BYTE2;
            end
            BYTE2: begin
                byte3 <= in;
                state <= BYTE3;
            end
            BYTE3: begin
                done <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
