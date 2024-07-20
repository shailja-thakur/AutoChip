module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_reg;
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin
                    if (in[2] == 1)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                end
                3'b001: begin
                    if (in[2] == 1)
                        state <= 3'b010;
                    else
                        state <= 3'b001;
                end
                3'b010: begin
                    if (in[2] == 1)
                        state <= 3'b011;
                    else
                        state <= 3'b000;
                end
                3'b011: begin
                    if (in[2] == 1)
                        state <= 3'b011;
                    else
                        state <= 3'b000;
                end
                default: state <= 3'b000;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            out_reg <= 24'b0;
        else if (state == 3'b011)
            out_reg <= {out_reg[15:0], in};
        else
            out_reg <= {out_reg[15:0], 8'b0};
    end

    assign out_bytes = out_reg;
    assign done = (state == 3'b011);

endmodule
