module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    // State encoding
    localparam WAIT_FOR_START = 2'd0,
               BYTE_1_RECV    = 2'd1,
               BYTE_2_RECV    = 2'd2,
               BYTE_3_RECV    = 2'd3;

    // Sequential logic for state transitions and byte counter
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            byte_count <= 2'd0;
        end else begin
            state <= next_state;
            if (state == BYTE_3_RECV)
                byte_count <= 2'd0;
            else if (state != WAIT_FOR_START)
                byte_count <= byte_count + 1;
        end
    end

    // Combinational logic for next state and done signal
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1)
                    next_state = BYTE_1_RECV;
            end

            BYTE_1_RECV: begin
                if (byte_count == 2'd1)
                    next_state = BYTE_2_RECV;
            end

            BYTE_2_RECV: begin
                if (byte_count == 2'd2)
                    next_state = BYTE_3_RECV;
            end

            BYTE_3_RECV: begin
                if (byte_count == 2'd3) begin
                    done = 1;
                    next_state = WAIT_FOR_START;
                end
            end
        endcase
    end

endmodule
