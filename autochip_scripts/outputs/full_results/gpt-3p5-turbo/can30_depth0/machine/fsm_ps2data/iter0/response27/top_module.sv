module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the states
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

reg [1:0] state;
reg [23:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        shift_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            BYTE1:
                if (in[2] == 1) begin
                    state <= BYTE2;
                    shift_reg <= {shift_reg[15:0], in};
                end else begin
                    state <= BYTE1;
                    shift_reg <= {shift_reg[15:0], in};
                end
            BYTE2:
                state <= BYTE3;
                shift_reg <= {shift_reg[15:0], in};
            BYTE3:
                state <= DONE;
                shift_reg <= {shift_reg[15:0], in};
            DONE:
                if (in[2] == 0) begin
                    state <= BYTE1;
                    shift_reg <= {shift_reg[15:0], in};
                end
        endcase
    end
end

always @(posedge clk) begin
    if (state == DONE) begin
        out_bytes <= shift_reg;
        done <= 1;
    end
end

endmodule
