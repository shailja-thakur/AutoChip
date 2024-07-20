module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin // Idle state
                if (in[3]) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin // First byte received
                state <= 2'b10;
            end
            2'b10: begin // Second byte received
                state <= 2'b11;
            end
            2'b11: begin // Third byte received
                state <= 2'b00;
                done <= 1;
            end
        endcase
    end
end

endmodule
