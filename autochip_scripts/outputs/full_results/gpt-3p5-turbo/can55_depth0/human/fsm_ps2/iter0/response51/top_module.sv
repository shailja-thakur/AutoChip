module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done_next;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        done_next <= 1'b0;
    end else begin
        case (state)
            3'b000: begin  // Waiting for first byte of message
                if (in[3] == 1'b1) 
                    state <= 3'b001;
            end
            3'b001: begin  // First byte of message received
                state <= 3'b010;
            end
            3'b010: begin  // Awaiting second byte of message
                state <= 3'b011;
            end
            3'b011: begin  // Second byte of message received
                state <= 3'b100;
            end
            3'b100: begin  // Awaiting third byte of message
                state <= 3'b101;
            end
            3'b101: begin  // Third byte of message received
                state <= 3'b000;
                done_next <= 1'b1;
            end
            default: state <= 3'b000;
        endcase
    end
end

assign done = done_next;

endmodule
