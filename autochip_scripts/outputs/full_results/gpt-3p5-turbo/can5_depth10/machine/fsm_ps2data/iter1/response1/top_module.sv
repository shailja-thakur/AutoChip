module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [2:0] state;
    reg [7:0] in_reg;

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
                        state <= 3'b010;
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
            in_reg <= 0;
        else
            in_reg <= in;
        
        if (reset)
            done <= 0;
        else if (state == 3'b011)
            done <= 1;
        else
            done <= 0;
    end

    always @(posedge clk) begin
        if (reset)
            out_bytes <= 0;
        else if (state == 3'b011)
            out_bytes <= in_reg;
        else
            out_bytes <= {out_bytes[15:0], in_reg};
    end

endmodule
