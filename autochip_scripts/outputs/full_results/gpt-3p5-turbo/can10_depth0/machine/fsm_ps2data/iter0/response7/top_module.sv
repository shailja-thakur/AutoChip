module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [2:0] state;
    reg [23:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                    shift_reg <= {shift_reg[15:0], in};
                end
                BYTE2: begin
                    state <= BYTE3;
                    shift_reg <= {shift_reg[15:0], in};
                end
                BYTE3: begin
                    state <= DONE;
                    shift_reg <= {shift_reg[15:0], in};
                end
                DONE: begin
                    if (in[2] == 0) begin
                        state <= BYTE1;
                    end else begin
                        state <= DONE;
                    end
                    shift_reg <= {shift_reg[15:0], in};
                end
                default: state <= BYTE1;
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == DONE) begin
            out_bytes <= shift_reg;
            done <= 1;
        end else begin
            out_bytes <= out_bytes;
            done <= 0;
        end
    end

endmodule
