module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg reset_sync;
reg [2:0] state;

always @(posedge clk)
begin
    reset_sync <= reset;
    if (reset_sync)
    begin
        state <= 0;
    end
    else
    begin
        case (state)
            0: // Idle state, waiting for start of a message
                begin
                    if (in[3])
                    begin
                        byte1 <= in;
                        state <= 1;
                    end
                end
            1: // Waiting for byte 2
                begin
                    byte2 <= in;
                    state <= 2;
                end
            2: // Waiting for byte 3
                begin
                    byte3 <= in;
                    state <= 3;
                end
            3: // Message received, setting done flag
                begin
                    done <= 1;
                    state <= 0;
                end
        endcase
    end
end

endmodule
