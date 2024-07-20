module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    // State Encoding
    localparam IDLE = 2'd0;
    localparam BYTE1 = 2'd1;
    localparam BYTE2 = 2'd2;
    localparam BYTE3 = 2'd3;

    // State Register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == BYTE1) begin
                byte_count <= 2'd1;
            end else if (next_state == BYTE2) begin
                byte_count <= 2'd2;
            end else if (next_state == BYTE3) begin
                byte_count <= 2'd3;
            end else if (next_state == IDLE) begin
                byte_count <= 2'd0;
            end

            if (byte_count == 3'd3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end

            BYTE1: begin
                next_state = BYTE2;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
