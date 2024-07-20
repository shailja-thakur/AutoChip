module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes = 24'b0,
    output reg done = 0
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            out_bytes <= 24'b0;
            done <= 0;
        end
        else begin
            case (state)
                2'b00: begin // BYTE1 state
                    if (in[2]) begin // transition to BYTE2 if third bit is 1
                        state <= 2'b01;
                    end else begin // transition to BYTE1 if third bit is 0
                        state <= 2'b00;
                    end
                    out_bytes <= (out_bytes << 8) | in; // shift input into register
                end

                2'b01: begin // BYTE2 state
                    if (in[2]) begin // transition to BYTE3 if third bit is 1
                        state <= 2'b10;
                    end else begin // transition to BYTE1 if third bit is 0
                        state <= 2'b00;
                    end
                    out_bytes <= (out_bytes << 8) | in; // shift input into register
                end

                2'b10: begin // BYTE3 state
                    if (in[2]) begin // transition to DONE if third bit is 1
                        state <= 2'b11;
                    end else begin // transition to BYTE1 if third bit is 0
                        state <= 2'b00;
                    end
                    out_bytes <= (out_bytes << 8) | in; // shift input into register
                end

                2'b11: begin // DONE state
                    state <= 2'b00; // transition to BYTE1
                    out_bytes <= (out_bytes << 8) | in; // shift input into register
                    done <= 1;
                end
            endcase
        end
    end

endmodule
