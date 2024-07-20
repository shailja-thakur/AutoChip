module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    // State encoding
    localparam WAIT_START = 2'b00;
    localparam BYTE1      = 2'b01;
    localparam BYTE2      = 2'b10;
    localparam BYTE3      = 2'b11;

    always @(*) begin
        done = 1'b0;
        case (state)
            WAIT_START: begin
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = WAIT_START;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = WAIT_START;
                done = 1'b1; // Signal done after receiving the third byte
            end
            default: begin
                next_state = WAIT_START;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_START;
        end else begin
            state <= next_state;
        end
    end

endmodule
