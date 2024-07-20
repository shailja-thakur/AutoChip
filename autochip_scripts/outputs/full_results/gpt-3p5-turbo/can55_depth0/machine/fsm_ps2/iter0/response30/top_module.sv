module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// State declaration
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_type;

// State register
reg [1:0] state_reg;

// Next state logic
always_ff @(posedge clk, posedge reset)
    if (reset) begin
        state_reg <= BYTE1;
        done <= 0;
    end else begin
        case (state_reg)
            BYTE1:
                if (in[2] == 1'b1) begin
                    state_reg <= BYTE2;
                end
            BYTE2:
                state_reg <= BYTE3;
            BYTE3:
                state_reg <= DONE;
            DONE:
                if (in[2] == 1'b0) begin
                    state_reg <= BYTE1;
                end else begin
                    state_reg <= BYTE2;
                end
        endcase
        done <= (state_reg == DONE);
    end

endmodule
