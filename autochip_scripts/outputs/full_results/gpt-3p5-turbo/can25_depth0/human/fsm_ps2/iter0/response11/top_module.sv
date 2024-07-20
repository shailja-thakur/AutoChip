module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] shift_reg [0:2];
reg [7:0] shifted_in;
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        shift_reg <= 0;
    end else begin
        case(state)
            0: begin // Waiting for the first byte with in[3]=1
                if (in[3] == 1) begin
                    shift_reg[0] <= in;
                    state <= 1;
                end
            end
            1: begin // Waiting for the second byte
                shift_reg[1] <= in;
                state <= 2;
            end
            2: begin // Waiting for the third byte
                shift_reg[2] <= in;
                shifted_in <= shift_reg[0];
                shift_reg[0] <= shift_reg[1];
                shift_reg[1] <= shift_reg[2];
                state <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
