module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_bytes_reg;
    reg [2:0] state;
    reg done;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes_reg <= 0;
            state <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin // BYTE1 state
                    if (in[2]) begin
                        state <= 1; // transition to BYTE2
                        out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    end else begin
                        state <= 0; // remain in BYTE1
                    end
                end

                1: begin // BYTE2 state
                    if (in[2]) begin
                        state <= 2; // transition to BYTE3
                        out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    end else begin
                        state <= 0; // transition to BYTE1
                        out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    end
                end

                2: begin // BYTE3 state
                    if (in[2]) begin
                        state <= 3; // transition to DONE
                        out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    end else begin
                        state <= 0; // transition to BYTE1
                        out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    end
                end

                3: begin // DONE state
                    state <= 0; // transition to BYTE1
                    out_bytes_reg <= {in, out_bytes_reg[23:8]};
                    done <= 1;
                end
            endcase
        end
    end

    assign out_bytes = out_bytes_reg;

endmodule
