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
        if (reset) begin
            out_reg <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[2])
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (in[2])
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (in[2])
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    state <= 0;
                end
                default: begin
                    state <= 0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 3 && out_reg != 0)
            done <= 1;
        else
            done <= 0;

        if (state == 0)
            out_reg <= {in, out_reg[23:8]};
    end

    assign out_bytes = out_reg;

endmodule
