module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;

    // States
    localparam IDLE  = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default state transitions and output
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
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
                done = 1'b1;
            end
        endcase
    end

endmodule
