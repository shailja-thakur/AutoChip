module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1, byte2, byte3;
reg done;
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Idle state
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin // Receiving byte 2
                byte2 <= in;
                state <= 2;
            end
            2: begin // Receiving byte 3
                byte3 <= in;
                state <= 3;
                done <= 1;
            end
            3: begin // Waiting for done signal to be registered
                state <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
