module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

// Define state values
localparam IDLE = 0;
localparam BYTE1 = 1;
localparam BYTE2 = 2;
localparam BYTE3 = 3;

// Synchronous reset
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (in[3]) begin
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
