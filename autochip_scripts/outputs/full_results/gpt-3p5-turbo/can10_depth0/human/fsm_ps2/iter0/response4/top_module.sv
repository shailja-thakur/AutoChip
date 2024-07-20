module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
// state definition
enum {IDLE, BYTE1, BYTE2, BYTE3} state;

// flip flop for storing the previous value of in[3]
reg prev_in3;

// register for storing the received byte count
reg [1:0] byte_count;

// register for storing the output done signal
reg done_reg;

always @(posedge clk) begin
    if (reset) begin
        // reset the FSM
        state <= IDLE;
        byte_count <= 0;
        done_reg <= 0;
    end else begin
        case (state)
            IDLE:
                if (in[3]) begin
                    // start of a new message
                    state <= BYTE1;
                    byte_count <= 1;
                    prev_in3 <= in[3];
                end
            BYTE1:
                if (in[3]) begin
                    // received byte 1 of the message
                    state <= BYTE2;
                    byte_count <= 2;
                    prev_in3 <= in[3];
                end else begin
                    // not byte 1 anymore, go back to idle state
                    state <= IDLE;
                    byte_count <= 0;
                end
            BYTE2:
                if (in[3]) begin
                    // received byte 2 of the message
                    state <= BYTE3;
                    byte_count <= 3;
                    prev_in3 <= in[3];
                end else begin
                    // not byte 2 anymore, go back to idle state
                    state <= IDLE;
                    byte_count <= 0;
                end
            BYTE3:
                if (in[3]) begin
                    // received byte 3 of the message, set done signal
                    state <= IDLE;
                    byte_count <= 0;
                    done_reg <= 1;
                end else begin
                    // not byte 3 anymore, go back to idle state
                    state <= IDLE;
                    byte_count <= 0;
                end
        endcase
    end
end

// assign the output done signal
assign done = done_reg;

endmodule
