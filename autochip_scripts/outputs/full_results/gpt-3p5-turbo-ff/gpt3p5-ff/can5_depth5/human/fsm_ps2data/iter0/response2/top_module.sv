module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
); 

    reg [7:0] byte1_reg;
    reg [7:0] byte2_reg;
    reg [7:0] byte3_reg;
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            done <= 0;
            byte1_reg <= 0;
            byte2_reg <= 0;
            byte3_reg <= 0;
        end else begin
            case(state)
                0: begin // Wait for in[3] to be 1
                    if (in[3] == 1) begin
                        byte1_reg <= in;
                        state <= 1;
                    end
                end
                1: begin // Wait for the second byte
                    byte2_reg <= in;
                    state <= 2;
                end
                2: begin // Wait for the third byte
                    byte3_reg <= in;
                    state <= 0;
                    done <= 1;
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (done) begin
            out_bytes[23:16] <= byte1_reg;
            out_bytes[15:8] <= byte2_reg;
            out_bytes[7:0] <= byte3_reg;
        end
    end

endmodule
