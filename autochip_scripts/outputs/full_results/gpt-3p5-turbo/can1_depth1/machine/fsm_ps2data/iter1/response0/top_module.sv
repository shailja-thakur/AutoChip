module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state;
    reg [23:0] reg_out_bytes;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 0;
            state <= 2'b00;
            reg_out_bytes <= 0;
        end else begin
            case(state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1)
                        state <= 2'b01; // transition to BYTE2 if third bit is 1
                    else
                        state <= 2'b00; // stay in BYTE1 if third bit is 0
                    reg_out_bytes <= {in, reg_out_bytes[23:8]}; // shift in input to register
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // transition to BYTE3
                    reg_out_bytes <= {reg_out_bytes[15:0], in, reg_out_bytes[23:16]}; // shift in input and shift register by 8 bits
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // transition to DONE
                    reg_out_bytes <= {reg_out_bytes[7:0], in, reg_out_bytes[23:8]}; // shift in input and shift register by 8 bits
                end
                2'b11: begin // DONE state
                    state <= 2'b00; // transition to BYTE1
                    out_bytes <= reg_out_bytes; // set out_bytes to contents of register
                    done <= 1;
                    reg_out_bytes <= {in, reg_out_bytes[23:8]}; // shift in input to register
                end
            endcase
        end
    end
endmodule
