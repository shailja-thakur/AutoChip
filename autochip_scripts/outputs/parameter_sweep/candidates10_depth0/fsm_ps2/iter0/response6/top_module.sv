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
    reg done;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done <= 0;
        end else begin
            case (state)
                0: begin // Wait for first byte with in[3]=1
                    if (in[3] == 1) begin
                        state <= 1;
                        byte1 <= in;
                    end
                end
                1: begin // Wait for second byte
                    state <= 2;
                    byte2 <= in;
                end
                2: begin // Wait for third byte
                    state <= 3;
                    byte3 <= in;
                end
                3: begin // Done receiving message
                    state <= 0;
                    done <= 1;
                end
            endcase
        end
    end
endmodule
