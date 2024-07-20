module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [23:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        done <= 0;
        shift_reg <= 0;
    end else begin
        case (state)
            0: begin // BYTE1
                shift_reg <= {shift_reg[15:0], in};
                if (in[2] == 1'b1)
                    state <= 1; // transition to BYTE2
                else
                    state <= 0; // stay in BYTE1
            end
            1: begin // BYTE2
                shift_reg <= {shift_reg[7:0], in};
                if (in[2] == 1'b1)
                    state <= 2; // transition to BYTE3
                else
                    state <= 0; // transition to BYTE1
            end
            2: begin // BYTE3
                shift_reg <= {shift_reg[7:0], in};
                state <= 3; // transition to DONE
            end
            3: begin // DONE
                state <= 0; // transition to BYTE1
            end
        endcase

        if (state == 3)
            done <= 1;
        else
            done <= 0;
    end
end

assign out_bytes = (done == 1) ? shift_reg : 0;

endmodule
