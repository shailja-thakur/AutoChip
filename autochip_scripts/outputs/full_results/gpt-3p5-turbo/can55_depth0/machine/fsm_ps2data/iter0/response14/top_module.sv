module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                2'b00: begin
                    if (in[2] == 1'b1)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
                2'b01: begin
                    state <= 2'b10;
                end
                2'b10: begin
                    if (in[2] == 1'b1)
                        state <= 2'b11;
                    else
                        state <= 2'b00;
                end
                2'b11: begin
                    state <= 2'b00;
                end
                default: state <= 2'b00;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            out_bytes <= 24'b0;
        else if (done)
            out_bytes <= out_bytes;
        else begin
            out_bytes <= {out_bytes[15:0], in};
        end
    end

    always @(posedge clk) begin
        if (state == 2'b11)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule
