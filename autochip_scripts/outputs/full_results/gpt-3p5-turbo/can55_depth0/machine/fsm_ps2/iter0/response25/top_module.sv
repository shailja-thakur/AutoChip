module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

// Define the state register
reg [1:0] state;

// Define the next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        case (state)
            BYTE1:
                state <= (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2:
                state <= BYTE3;
            BYTE3:
                state <= DONE;
            DONE:
                state <= (in[2] == 1'b1) ? BYTE2 : BYTE1;
        endcase
    end
end

// Define the output logic
always @(posedge clk) begin
    done <= (state == DONE);
end

endmodule
