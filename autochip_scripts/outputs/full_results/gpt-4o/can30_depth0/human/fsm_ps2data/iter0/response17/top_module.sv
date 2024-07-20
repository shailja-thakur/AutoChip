module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state;
    reg [7:0] byte1, byte2;

    // State encoding
    localparam IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
        end
        else begin
            done <= 0; // Default done to 0
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        byte1 <= in;
                        state <= BYTE1;
                    end
                end
                BYTE1: begin
                    byte2 <= in;
                    state <= BYTE2;
                end
                BYTE2: begin
                    out_bytes <= {byte1, byte2, in};
                    state <= BYTE3;
                    done <= 1;
                end
                BYTE3: begin
                    if (in[3] == 1'b1) begin
                        byte1 <= in;
                        state <= BYTE1;
                        done <= 0;
                    end
                    else begin
                        state <= IDLE; // Wait for next valid starting byte
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
