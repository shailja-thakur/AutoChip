module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state, next_state;

    // State encoding
    localparam WAIT   = 2'd0,
               BYTE1  = 2'd1,
               BYTE2  = 2'd2,
               BYTE3  = 2'd3;

    // State transition on clock edge.
    always @(posedge clk) begin
        if (reset)
            state <= WAIT;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT:   if (in[3]) next_state = BYTE1; else next_state = WAIT;
            BYTE1:  next_state = BYTE2;
            BYTE2:  next_state = BYTE3;
            BYTE3:  next_state = WAIT;
            default: next_state = WAIT;
        endcase
    end

    // Output logic
    assign done = (state == BYTE3);

endmodule
