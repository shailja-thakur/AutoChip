module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [23:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        shift_reg <= 0;
    end else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            BYTE2: begin
                if (in[2] == 1)
                    state <= BYTE3;
                else
                    state <= BYTE1;
            end
            BYTE3: begin
                if (in[2] == 1)
                    state <= DONE;
                else
                    state <= BYTE1;
            end
            DONE: begin
                if (in[2] == 0)
                    state <= BYTE1;
                else
                    state <= DONE;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        out_bytes <= 0;
    end else begin
        if (state == DONE)
            out_bytes <= shift_reg;
    end
end

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 0;
    end else begin
        shift_reg <= {shift_reg[15:0], in};
    end
end

assign done = (state == DONE);

endmodule
