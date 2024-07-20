module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;
    reg done_internal;

    // State encoding
    localparam WAIT_BYTE1 = 2'b00,
               BYTE1_RECEIVED = 2'b01,
               BYTE2_RECEIVED = 2'b10,
               DONE = 2'b11;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_BYTE1;
            byte_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == WAIT_BYTE1 || state == BYTE2_RECEIVED)
                byte_count <= 2'b00;
            else if (state == BYTE1_RECEIVED || state == BYTE2_RECEIVED)
                byte_count <= byte_count + 1;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done_internal = 0;
  
        case (state)
            WAIT_BYTE1: begin
                if (in[3]) begin
                    next_state = BYTE1_RECEIVED;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = DONE;
            end
            DONE: begin
                done_internal = 1;
                next_state = WAIT_BYTE1;
            end
            default: next_state = WAIT_BYTE1;
        endcase
    end

    assign done = done_internal;

endmodule
