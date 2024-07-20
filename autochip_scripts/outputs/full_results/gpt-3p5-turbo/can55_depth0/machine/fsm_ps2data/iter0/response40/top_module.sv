module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_reg;
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_reg <= 0;
            state <= 2'b00;
        end else begin
            case(state)
                2'b00: begin // BYTE1 state
                    state <= (in[2] == 1) ? 2'b01 : 2'b00;
                    out_reg <= {out_reg[15:0], in};
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10;
                    out_reg <= {out_reg[15:0], in};
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11;
                    out_reg <= {out_reg[15:0], in};
                end
                2'b11: begin // DONE state
                    state <= (in[2] == 0) ? 2'b00 : 2'b00;
                    out_reg <= (in[2] == 0) ? {out_reg[15:0], in} : out_reg;
                end
            endcase
        end
    end

    assign out_bytes = out_reg;
    assign done = (state == 2'b11);

endmodule
