module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] byte1;
    reg [7:0] byte2;
    reg [7:0] byte3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
        end else begin
            case (state)
                0: begin // Waiting for first byte with in[3]=1
                    if (in[3] == 1) begin
                        byte1 <= in;
                        state <= 1;
                    end
                end
                1: begin // Waiting for second byte
                    byte2 <= in;
                    state <= 2;
                end
                2: begin // Waiting for third byte
                    byte3 <= in;
                    state <= 3;
                end
                3: begin // Done, signaling receipt of a message
                    done <= 1;
                    byte1 <= 0;
                    byte2 <= 0;
                    byte3 <= 0;
                    state <= 0;
                end
                default: begin
                    state <= 0;
                    byte1 <= 0;
                    byte2 <= 0;
                    byte3 <= 0;
                end
            endcase
        end
    end

endmodule
