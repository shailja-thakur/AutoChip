module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;

// State Definitions
parameter IDLE = 0;
parameter BYTE1 = 1;
parameter BYTE2 = 2;
parameter BYTE3 = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    state <= BYTE1;
                end
            end
            BYTE1: begin
                state <= BYTE2;
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= IDLE;
            end
        endcase
    end
end

assign done = (state == BYTE3);

endmodule
