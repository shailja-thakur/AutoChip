module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state;
    reg [7:0] byte1;
    reg [7:0] byte2;
    reg [7:0] byte3;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin // Idle state
                    if (in[3] == 1) begin
                        byte1 <= in;
                        state <= 1;
                    end
                end
                1: begin // Byte 1 received
                    byte2 <= in;
                    state <= 2;
                end
                2: begin // Byte 2 received
                    byte3 <= in;
                    state <= 3;
                end
                3: begin // Byte 3 received
                    done <= 1;
                    state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end

endmodule
