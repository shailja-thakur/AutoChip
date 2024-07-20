module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 2'b00;  // initial state BYTE1
            done <= 0;
            out_bytes <= 0;
        end else begin
            case(state)
                2'b00: begin  // BYTE1 state
                    if (in[2] == 1'b1) begin
                        state <= 2'b01;  // transition to BYTE2
                    end else begin
                        state <= 2'b00;  // self-transition
                    end
                end
                2'b01: begin  // BYTE2 state
                    state <= 2'b10;  // transition to BYTE3
                end
                2'b10: begin  // BYTE3 state
                    state <= 2'b11;  // transition to DONE
                end
                2'b11: begin  // DONE state
                    if (in[2] == 1'b0) begin
                        state <= 2'b00;  // transition to BYTE1
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 2'b11) begin  // DONE state
            done <= 1;
            out_bytes <= out_bytes_reg;
        end else begin
            done <= 0;
            out_bytes <= {out_bytes_reg[15:0], in};  // shift in input to register
        end
    end

endmodule
