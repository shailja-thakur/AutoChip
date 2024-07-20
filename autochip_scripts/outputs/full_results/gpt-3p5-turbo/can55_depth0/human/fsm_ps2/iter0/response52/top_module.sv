module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1, byte2, byte3;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Wait for start of message
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin // Receive byte 2
                byte2 <= in;
                state <= 2;
            end
            2: begin // Receive byte 3 and assert done
                byte3 <= in;
                state <= 3;
                done <= 1;
            end
            3: begin // Wait for start of next message
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                    done <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

endmodule
