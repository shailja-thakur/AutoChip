module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [2:0] state;
    reg [23:0] reg_out_bytes;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            reg_out_bytes <= 0;
        end else begin
            case (state)
                BYTE1:
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                BYTE2:
                    state <= BYTE3;
                BYTE3:
                    state <= DONE;
                DONE:
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
            endcase
            if (state == DONE) begin
                done <= 1;
                out_bytes <= reg_out_bytes;
            end else begin
                done <= 0;
                reg_out_bytes <= {reg_out_bytes[15:0], in};
            end
        end
    end
endmodule
